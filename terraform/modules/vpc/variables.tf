variable "vpc_cidr" {
  description = "Dải IP cho VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Dải IP cho Public Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Dải IP cho Private Subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "az" {
  description = "Availability Zone để triển khai (ví dụ: us-east-1a)"
  type        = string
  default     = "us-east-1a"
}
