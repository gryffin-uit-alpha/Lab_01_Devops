provider "aws" {
  region = "us-east-1" # Hoặc region bạn muốn
}

# Gọi module VPC
module "vpc" {
  source = "./modules/vpc"

  # Truyền giá trị cho các biến (nếu muốn ghi đè default)
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "sg" {
  source = "./modules/security_groups"

  vpc_id       = module.vpc.vpc_id # Lấy ID từ output của module VPC
  my_public_ip = var.my_ip         # THAY BẰNG IP THẬT CỦA BẠN (Search: what is my ip)
}

module "ec2" {
  source = "./modules/ec2"

  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  public_sg_id  = module.sg.public_sg_id
  private_sg_id = module.sg.private_sg_id

  key_name = var.key_pair_name # Thay bằng tên Key Pair bạn đã tạo trên AWS Console
}

# Xuất IP ra màn hình terminal sau khi chạy xong
output "connect_command" {
  value = "ssh -i ${var.key_pair_name}.pem ec2-user@${module.ec2.public_instance_ip}"
}

output "app_server_private_ip" {
  value = module.ec2.private_instance_ip
}
