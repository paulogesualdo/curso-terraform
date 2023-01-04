terraform {

  required_version = "1.3.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  backend "s3" {
    bucket = "tfstate-968339500772"                         // here is not possible to use variables because this is the first module that will be executed
    key    = "dev/01-usando-remote-state/terraform.tfstate" // path where the terraform.tfstate file will be in the s3 bucket
    region = "us-east-1"
  }

}

provider "aws" {
  region = var.aws-region
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "${random_pet.bucket.id}-${var.environment}"
  tags   = local.common_tags
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

resource "aws_s3_bucket_object" "my-test-bucket-object" {
  bucket       = aws_s3_bucket.my-test-bucket
  key          = "config/${local.ip_filepath}"
  source       = local.ip_filepath
  etag         = filemd5(local.ip_filepath)
  tags         = local.common_tags
  content_type = "application/json"
}

resource "aws_s3_bucket_object" "random" {
  bucket       = aws_s3_bucket.my-test-bucket
  key          = "config/${random_pet.bucket.id}.json"
  source       = local.ip_filepath
  etag         = filemd5(local.ip_filepath)
  tags         = local.common_tags
  content_type = "application/json"
}

resource "aws_s3_bucket" "manual-import" {
  bucket = "bucket-created-at-console-123123"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote-state" {

  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"

  versioning {
    enabled = true
  }

  tags = {
    Description = "Stores Terraform remote state files"
    ManagedBy   = "Terraform"
    Owner       = "Paulo Gesualdo"
  }

}

resource "aws_instance" "remote-state" {

  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = "Remote State"
    Env  = "dev"
  }

}

