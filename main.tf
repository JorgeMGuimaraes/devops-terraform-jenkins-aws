terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

module "jenkins_server" {
  source        = "./modules/compute"
  instance_name = "Jenkins Server"
  user_data     = file("./modules/compute/install_jenkins.sh")
  environment   = "Test"
}

module "ngnix_server" {
  source        = "./modules/compute"
  instance_name = "Ngnix Web Server"
  user_data     = file("./modules/compute/install_httpd.sh")
  environment   = "Test"
}

module "my_portfolio_vpc" {
  source = "./modules/network"
}