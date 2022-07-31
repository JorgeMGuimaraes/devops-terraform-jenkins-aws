resource "aws_instance" "portifolio_t2_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group]
  key_name               = "project_portfolio"
  user_data                 = var.user_data
  tags = {
    Name    = var.instance_name
    Project = "project_portfolio"
    Terraform = true
    Environment = var.environment
  }
}
