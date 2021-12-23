

```shell
terraform workspace new lab
terraform init
terraform plan -out terraform.tfplan
terraform apply terraform.tfplan
```

To build the AMI:
```shell
$(terraform output packer_build_command)
```

To delete the stack
```shell
terraform destroy
```
