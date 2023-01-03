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
  region = var.aws-region
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket-paulogesualdo"
  tags   = var.dev_tags
}

resource "aws_s3_bucket_acl" "my-test-bucket-acl" {
  bucket = aws_s3_bucket.my-test-bucket.id
  acl    = "private"
}

resource "aws_instance" "my-test-instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  tags          = var.dev_tags
}