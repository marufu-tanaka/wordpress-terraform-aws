variable "app_name" {
  type        = string
  description = "Application name"
}

variable "env_name" {
  type        = string
  description = "Environment name"
}

variable "ami_value" {
    description = "value for the ami"
}

variable "instance_type_value" {
    description = "value for instance_type"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnets" {
  type        = map(string)
  description = "Public subnet CIDRs"
}

variable "private_subnets" {
  type        = map(string)
  description = "Private subnet CIDRs"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones for subnets"
}