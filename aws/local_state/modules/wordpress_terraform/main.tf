locals {
  prefix = "${var.app_name}-${var.env_name}"
}

# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.prefix}-vpc"
  }
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.prefix}-igw"
  }
}

# -------------------------
# Private Subnets
# -------------------------
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = element(var.availability_zones, index(keys(var.private_subnets), each.key))

  tags = {
    Name = "${local.prefix}-private-subnet-${each.key}"
  }
}

# -------------------------
# Route Table for Public Subnets
# -------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${local.prefix}-RT"
  }
}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "this" {
  name        = "${local.prefix}-SG"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.prefix}-SG"
  }
}

# -------------------------
# EC2 Instance
# -------------------------
resource "aws_instance" "this" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
  subnet_id     = aws_subnet.public["a"].id
  vpc_security_group_ids = [aws_security_group.this.id]
  associate_public_ip_address = true
  tags = {
    Name = "${local.prefix}-ec2"
    Application=${var.app_name}
  }

}

