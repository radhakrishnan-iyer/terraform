# how to store the tf state file in remote location
terraform {
    backend "s3" {
      bucket = "rk-tf-state"
      region = "us-east-1"
      key = "terraform.tfstate"
    }
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

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "web" {
  ami = "ami-02396cdd13e9a1257"
  instance_type = "t3.micro"
}