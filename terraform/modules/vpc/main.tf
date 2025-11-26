# 1. Tạo VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { Name = "my-vpc" }
}

# 2. Tạo Internet Gateway (Cho Public Subnet ra net)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "my-igw" }
}

# 3. Tạo Subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true # Tự động cấp Public IP cho EC2 ở đây
  availability_zone       = var.az

  tags = { Name = "public-subnet" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az

  tags = { Name = "private-subnet" }
}

# 4. Cấu hình NAT Gateway (Cho Private Subnet ra net an toàn)
# Cần một Elastic IP (EIP) tĩnh cho NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id # NAT GW phải nằm ở Public Subnet!

  depends_on = [aws_internet_gateway.igw] # Đợi IGW tạo xong mới tạo NAT
  tags       = { Name = "my-nat-gw" }
}

# 5. Route Tables (Bảng định tuyến)

# Route Table cho Public Subnet (Đi qua Internet Gateway)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "public-rt" }
}

# Route Table cho Private Subnet (Đi qua NAT Gateway)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = { Name = "private-rt" }
}

# 6. Gán Route Table vào Subnet (Association)
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
