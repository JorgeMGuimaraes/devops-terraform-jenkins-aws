## Virtual Private Cloud ##

resource "aws_vpc" "jenkins_vpc" {
    cidr_block = var.vpc_cidr_block
    instance_tenacy = var.instance_tenacy
    enable_dns_support = var.dns_support
    enable_dns_hostnames = var.dns_hostnames
    tags = {
        Name = "VPC Jenkins"
    }
}

## Virtual Subnet ##

resource "aws_subnet" "Public_Subnet" {
    vpc_id = aws_vpc.jenkins_vpc.id
    availability_zone = var.availability_zone
    cidr_block = var.public_cidr_block
    map_public_ip_on_launch = var.map_public_ip
        tags = {
        Name = "Public Subnet"
    }
}
