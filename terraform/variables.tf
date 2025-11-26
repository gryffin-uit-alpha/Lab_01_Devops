# project-root/variables.tf

variable "aws_region" {
  description = "AWS Region to deploy to"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  default     = "my-assignment"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "my_ip" {
  description = "IP Address for SSH access"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the existing Key Pair on AWS"
  type        = string
}
