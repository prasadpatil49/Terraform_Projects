output "s3_bucket_arn" {
  value = module.s3_bucket_images.s3_bucket_arn
}

output "lambda_function_url" {
  value = module.lamdba_function.lambda_function_url
}