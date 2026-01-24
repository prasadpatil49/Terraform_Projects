output "s3_bucket_id" {
    value = module.s3_public_static_web.s3_bucket_id
    description = "The ID of the S3 bucket"
}

output "s3_bucket_website_endpoint" {
    value = module.s3_public_static_web.s3_bucket_website_endpoint
    description = "The website endpoint of the S3 bucket"
}

output "s3_bucket_website_domain" {
    value = module.s3_public_static_web.s3_bucket_website_domain
    description = "The website domain of the S3 bucket"
}