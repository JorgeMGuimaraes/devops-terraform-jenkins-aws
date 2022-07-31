variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Default instance type used in Project Portfolio"
}

variable "ami_id" {
  type        = string
  default     = "ami-037c192f0fa52a358"
  description = "Default image (Amazon Linux) used in Project Portfolio"
}

variable "instance_name" {
  type        = string
  description = "Instance name (identifier)"
}

variable "security_group" {
  type        = string
  default     = "sg-0a81f4e28bb90bbdd"
  description = "Default Security Group used in Project Portfolio"
}

variable "environment" {
  type        = string
  default     = "Test"
  description = "Current project environment (Test, Dev, Prod)"
}
