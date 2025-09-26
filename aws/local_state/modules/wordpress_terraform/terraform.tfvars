app_name = "wordpress-lp"
env_name = "dev"

vpc_cidr = "10.0.0.0/16"

public_subnets = {
  "a" = "10.0.0.0/22"
  "b" = "10.0.1.0/22"
}

private_subnets = {
  "a" = "10.0.2.0/22"
  "b" = "10.0.3.0/22"
}

availability_zones = ["ap-northeast-3a", "ap-northeast-3c"]