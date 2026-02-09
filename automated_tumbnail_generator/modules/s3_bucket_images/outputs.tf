output "s3_bucket_arn" {
  value = aws_s3_bucket.images_bucket.arn
}
output "s3_bucket_id" {
  value = aws_s3_bucket.images_bucket.id
}