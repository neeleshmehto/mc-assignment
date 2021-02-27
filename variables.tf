variable "aws_region" {
	default = "us-east-1"
}

variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "private_subnet_cidr" {
#	type = "string"
	default = "10.20.1.0/24"
}

variable "public_subnet_cidr" {
	type = "string"
	default = "10.20.3.0/24"
}

variable "webservers_ami" {
  default = "ami-096fda3c22c1c990a"
}

variable "instance_type" {
  default = "t2.micro"
}


