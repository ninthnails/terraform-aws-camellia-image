output "bucket_name" {
  value = local.bucket_name
}

output "build_command" {
  value = "aws --region ${data.aws_region.current.name} codebuild start-build --project-name ${aws_codebuild_project.packer.name}${length(replace(trimspace(aws_s3_bucket_object.sources.version_id), "null", "")) > 0 ? format(" --source-version '%s'", aws_s3_bucket_object.sources.version_id) : ""}"
}
