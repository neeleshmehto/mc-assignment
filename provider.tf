terraform {
  required_version = "0.12"
}
provider "aws" {
	access_key = ""    
        secret_key = ""
	region = "${var.aws_region}"
}


