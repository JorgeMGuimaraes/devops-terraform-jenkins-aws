## Virtual Private Cloud ##

resource "aws_vpc" "portfolio_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames
  tags = {
    Name = "VPC Jenkins"
  }
}

## Virtual Subnet ##

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.portfolio_vpc.id
  availability_zone       = var.availability_zone
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = var.map_public_ip
  tags = {
    Name = "Public Subnet"
  }
}

## Network Access Control List ##
#TODO: replace ingress/ egress with nacl_rule

resource "aws_network_acl" "public_network_acl" {
  vpc_id     = aws_vpc.portfolio_vpc.id
  subnet_ids = [aws_subnet.public_subnet.id]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.public_dest_cidr_block
    from_port  = var.port_http
    to_port    = var.port_http
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.public_dest_cidr_block
    from_port  = var.port_http
    to_port    = var.port_http
  }
}

## Internet Gateway ##

resource "aws_internet_gateway" "portifolio_igw" {
  vpc_id = aws_vpc.portfolio_vpc.id
  tags = {
    Name = "Internet gateway Portifolio"
  }
}

## Route Table ##

resource "aws_route_table" "portifolio_rt" {
  vpc_id = aws_vpc.portfolio_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.portifolio_rt.id
  destination_cidr_block = var.public_dest_cidr_block
  gateway_id             = aws_internet_gateway.portifolio_igw.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.portifolio_rt.id
}
