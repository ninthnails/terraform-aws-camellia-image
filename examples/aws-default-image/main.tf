terraform {
  required_providers {
    archive = {
      source = "hashicorp/archive"
      version = ">= 2.2"
    }
    aws = {
      source = "hashicorp/aws"
      version = ">= 2.70"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.1"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1"
    }
  }
  required_version = ">= 0.13"
}

#################
# Variables
#################
variable "aws_region" {
  default = "us-east-1"
}

variable "prefix" {
  default = "camellia-example"
}

#################
# Providers
#################
provider "aws" {
  region = var.aws_region
}

provider "archive" {
}

provider "random" {
}

#################
# Modules
#################
module "image" {
  source = "../../"
  packer_template = "aws-default.json"
  prefix = var.prefix
}

#################
# Outputs
#################
output "packer_build_command" {
  value = module.image.build_command
}

output "build_project_url" {
  value = module.image.build_project_url
}

output "s3_bucket_name" {
  value = module.image.bucket_name
}
