terraform {
  required_version = ">= 1.10.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "terraweek-state-vrushali-2026"
    key            = "terraweek-capstone/terraform.tfstate"
    region         = "us-west-2"
    use_lockfile = true
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"
}
