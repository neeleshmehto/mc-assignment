terraform {
  required_version = "0.12"
}
provider "aws" {
	access_key = "AKIAZGIODGKA4IO3MZFP"
        secret_key = "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"
	region = "${var.aws_region}"
}


