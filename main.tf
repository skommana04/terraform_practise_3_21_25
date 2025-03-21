provider "aws" {
  region = "us-east-1"

}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "saibucket0123456789"

  tags = {
    Name        = "saibucket0123456789"
    Environment = "Dev"
  }
}

