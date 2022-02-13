output "bucket_name" {
  description = "The name of the S3 bucket create to store files used by CodeBuild job."
  value       = local.bucket_name
}

output "build_command" {
  description = "The AWS CLI command to run for triggering the CodeBuild job that will create the AMI."
  value       = "aws --region ${data.aws_region.current.name} codebuild start-build --project-name ${aws_codebuild_project.packer.name}${length(replace(trimspace(aws_s3_bucket_object.sources.version_id), "null", "")) > 0 ? format(" --source-version '%s'", aws_s3_bucket_object.sources.version_id) : ""}"
}

output "build_project_url" {
  description = "The URL for CodeBuild project in the AWS Console."
  value       = "https://${data.aws_region.current.name}.console.aws.amazon.com/codesuite/codebuild/${data.aws_caller_identity.current.account_id}/projects/${aws_codebuild_project.packer.name}"
}
