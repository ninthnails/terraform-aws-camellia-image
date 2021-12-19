terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.70"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1"
    }
  }
  required_version = ">= 0.13"
}
