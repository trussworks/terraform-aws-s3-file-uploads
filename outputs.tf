output "file_uploads_bucket_arn" {
  description = "ARN of the file uploads bucket"
  value       = module.file_uploads_s3_bucket.arn
}
