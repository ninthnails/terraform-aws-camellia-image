#################
# Variables
#################
variable "aws_region" {
  default = "us-east-1"
}

variable "prefix" {
  default = "camellia-example"
}

variable "vpc_id" {
}

variable "private_subnet_ids" {
  type = list(string)
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
  packer_template = "aws-private.json"
  prefix = var.prefix
  subnet_ids = var.private_subnet_ids
  vpc_id = var.vpc_id
}

#################
# Outputs
#################
output "packer_build_command" {
  value = module.image.build_command
}

output "s3_bucket_name" {
  value = module.image.bucket_name
}
