terraform {

  backend "s3" {
    bucket = "191115909623-terraform-cloud-technologies"
    key = "main/dev/terraform.ftstate"
    region = "eu-central-1"

  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57.1"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
