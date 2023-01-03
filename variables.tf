variable "aws-region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "instance_ami" {
  type        = string
  description = ""
  default     = "ami-03c3a7e4263fd998c"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t3.micro"
}

variable "dev_tags" {
  type        = map(string)
  description = ""
  default = {
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Paulo Gesualdo"
  }
}