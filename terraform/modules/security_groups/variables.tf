variable "vpc_id" {
  description = "ID của VPC sẽ chứa Security Group"
  type        = string
}

variable "my_public_ip" {
  description = "Địa chỉ IP cá nhân của bạn (dạng CIDR, vd: 1.2.3.4/32)"
  type        = string
}
