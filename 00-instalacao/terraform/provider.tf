terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Configure the AWS Provider
# Using environment variables: AWS_SECRET_ACCESS_KEY, AWS_SECRET_ACCESS_KEY, AWS_REGION
provider "aws" {
}