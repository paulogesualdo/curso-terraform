terraform {
  required_version = "1.3.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket-paulogesualdo"

  tags = {
    Name        = "My first Terraform bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Paulo Gesualdo"
    UpdatedAt   = "2023-01-03"
  }
}

resource "aws_s3_bucket_acl" "my-test-bucket-acl" {
  bucket = aws_s3_bucket.my-test-bucket.id
  acl    = "private"
}

resource "aws_instance" "my-test-instance" {
  ami           = "ami-03c3a7e4263fd998c"
  instance_type = "t3.micro"

  tags = {
    Name = "My first Terraform instance"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Paulo Gesualdo"
    UpdatedAt   = "2023-01-03"
  }
}