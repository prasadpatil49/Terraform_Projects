output "s3_bucket_id" {
    value = aws_s3_bucket.s3_bucket.id
    description = "The ID of the S3 bucket"
}

output "s3_bucket_website_endpoint" {
    value = aws_s3_bucket_website_configuration.s3_bucket_website_configuration.website_endpoint
    description = "The website endpoint of the S3 bucket"
}

output "s3_bucket_website_domain" {
    value = aws_s3_bucket_website_configuration.s3_bucket_website_configuration.website_domain
    description = "The website domain of the S3 bucket"
}