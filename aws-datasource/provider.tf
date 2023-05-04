provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "aws_region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["679593333241"]
  filter {
    name = "name"
    values = ["SupportedImages ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}