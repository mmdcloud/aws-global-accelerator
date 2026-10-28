terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Default AWS Provider (required for root AWS Global Accelerator resources)
provider "aws" {
  region = "us-east-1"
}

# Regional AWS Providers
provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "nv"
  region = "us-east-1"
}
