provider "aws" {
  region     = "us-east-2"
  access_key = var.accesskey
  secret_key = var.secretkey
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.example.id # 同一个模块下，不需要output 直接引用
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
}

data "aws_vpc" "selected" {
  default = true
}

resource "aws_subnet" "test-subnet-1" {
  vpc_id            = data.aws_vpc.selected.id
  cidr_block        = "172.31.48.0/20"
  availability_zone = "us-east-2a"
  tags = {
    Name = "house"
  }
}

resource "aws_subnet" "test-subnet-2" {
  vpc_id            = data.aws_vpc.selected.id
  cidr_block        = "172.31.64.0/20"
  availability_zone = "us-east-2b"
  tags = {
    Name = "horse"
  }
}




