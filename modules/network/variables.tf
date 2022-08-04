variable "region" {
}
variable "availability_zone" {
     default = "sa-east-1a"
}
variable "instance_tenacy" {
    default = "default"
}
variable "dns_support" {
    default = true
}
variable "dns_hostnames" {
    default = true
}
variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}
variable "public_cidr_block" {
    default = "10.0.1.0/24"
}
variable "privatesCIDRblock" {
    default = "10.0.2.0/24"
}
variable "publicdestCIDRblock" {
    default = "0.0.0.0/0"
}
variable "localdestCIDRblock" {
    default = "10.0.0.0/16"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "map_public_ip" {
    default = true
}