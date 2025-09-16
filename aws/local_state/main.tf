terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.13.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-northeast-1"
}

resource "aws_instance" "xxxxx" {
  ami           = "xxxxxxx"
  instance_type = "t2.micro"

  tags = {
    Name = "MyProject_Demo"
  }

}
resource "aws_s3_bucket" "name xxxxx" {
  # With account id, this S3 bucket names can be *globally* unique.
  bucket = "${local.account_id}-name"

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
}
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }





