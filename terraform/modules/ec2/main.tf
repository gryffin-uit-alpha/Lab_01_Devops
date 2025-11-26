variable "public_subnet_id" { type = string }
variable "private_subnet_id" { type = string }
variable "public_sg_id" { type = string }
variable "private_sg_id" { type = string }

variable "ami_id" {
  description = "AMI ID của hệ điều hành (VD: Amazon Linux 2)"
  type        = string
  # Bạn có thể tìm AMI ID trong AWS Console hoặc dùng Data Source để lấy tự động
  default = "ami-0cff7528ff583bf9a" # Lưu ý: ID này thay đổi theo Region (đây là ví dụ us-east-1)
}

variable "instance_type" {
  default = "t3.micro" # Loại máy nhỏ nhất để tiết kiệm chi phí
}

variable "key_name" {
  description = "Tên Key Pair đã tạo trên AWS để SSH"
  type        = string
}
