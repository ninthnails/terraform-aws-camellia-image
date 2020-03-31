variable "prefix" {
  default = "camellia"
}

variable "vpc_id" {
}

variable "subnet_ids" {
  type = list(string)
}

variable "packer_template" {
  default = "aws-default.json"
}

variable "packer_instance_type" {
  default = "t3.micro"
  description = "Type of EC2 instance use for Packer. Must be an EBS optimized type."
}

variable "tags" {
  type = map(string)
  default = {}
}
