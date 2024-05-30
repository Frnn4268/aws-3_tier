terraform {
  #backend "s3" {
  #  bucket         = "shoppr-remote-backend"
  #  key            = "global/s3/terraform.tfstate"
  #  region         = "us-east-1"
  #  dynamodb_table = "shoppr-tfstate-locking"
  #  encrypt        = true
  #}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      App         = var.app_name
      Environment = var.environment
      Terraform   = "True"
    }
  }
}

# Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
