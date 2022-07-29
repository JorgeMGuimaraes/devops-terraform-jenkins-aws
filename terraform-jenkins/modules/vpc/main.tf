# Variable that holds the CIDR block for the VPC
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
}

# Creting the VPC and calling it tutorial_vpc
resource "aws_vpc" "tutorial_vpc" {
  
  cidr_block = var.vpc_cidr_block # Setting the CIDR block of the VPC to the variable vpc_cidr_block
  enable_dns_hostnames  = true    # Enabling DNS hostnames on the VPC
  tags                  = {       # Setting the tag Name to tutorial_vpc
    Name = "tutorial_vpc"
  }
}

# Creating the Internet Gateway and naming it tutorial_igw
resource "aws_internet_gateway" "tutorial_igw" {
  vpc_id    = aws_vpc.tutorial_vpc.id # Attaching it to the VPC called tutorial_vpc
  tags      = {                       # Setting the Name tag to tutorial_igw
    Name = "tutorial_igw"
  }
}

# Creating the public route table and calling it tutorial_public_rt
resource "aws_route_table" "tutorial_public_rt" {
  vpc_id = aws_vpc.tutorial_vpc.id                    # Creating it inside the tutorial_vpc VPC
  route {                                             # Adding the internet gateway to the route table
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tutorial_igw.id
  }
}

# Variable that holds the CIDR block for the public subnet
variable "public_subnet_cidr_block" {
  description = "CIDR block of the public subnet"
}

# Data store that holds the available AZs in our region
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating the public subnet and naming it tutorial_public_subnet
resource "aws_subnet" "tutorial_public_subnet" {
  vpc_id            = aws_vpc.tutorial_vpc.id                         # Creating it inside the tutorial_vpc VPC
  cidr_block        = var.public_subnet_cidr_block                    # Setting the CIDR block to the variable public_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]  # Setting the AZ to the first one in our available AZ data store
  tags = {                                                            # Setting the tag Name to "tutorial_public_subnet"
    Name = "tutorial_public_subnet"
  }
}

# Associating our public subnet with our public route table
resource "aws_route_table_association" "public" {
route_table_id    = aws_route_table.tutorial_public_rt.id # The ID of our public route table called tutorial_public_rt
subnet_id         = aws_subnet.tutorial_public_subnet.id  # The ID of our public subnet called tutorial_public_subnet
}
