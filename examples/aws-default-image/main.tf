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
