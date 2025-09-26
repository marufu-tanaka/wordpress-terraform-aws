terraform {
  backend "s3" {
    bucket         = "terraform-wordpress-lp" 
    key            = "wordpress-lp/terraform.tfstate"
    region         = "ap-northeast-3"
  }
}