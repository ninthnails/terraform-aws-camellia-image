variable "prefix" {
  default = "camellia"
  description = "Resources will be prevfixed with this."
}

variable "vpc_id" {
  description = "ID of the VPC where to create the image."
}

variable "subnet_ids" {
  description = "ID of the subnet in the VPC where the Packer instance will run."
  type = list(string)
}

variable "packer_template" {
  default = "aws-default.json"
  description = "The name of the template file use by Packer to create the image. Must be a relative path to module root."
}

variable "packer_instance_type" {
  default = "t3.micro"
  description = "Type of EC2 instance use for Packer. Must be an EBS optimized type and support ENA."
}

variable "tags" {
  default = {}
  description = "A mapping of tags to assign to all resources."
  type = map(string)
}
