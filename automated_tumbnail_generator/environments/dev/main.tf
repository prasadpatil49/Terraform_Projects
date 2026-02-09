module "s3_bucket_images" {
  source = "../../modules/s3_bucket_images"
  bucket_name = "dev-thumbnail"
  environment = "dev"
}

module "lamdba_function" {
  source = "../../modules/lamdba_function"
  function_name = "dev-thumbnail-generator"
  environment = "dev"
  code_path = "../../python-code/"
  archive_path = "../../python-code/python_lambda.zip"
  depends_on = [module.s3_bucket_images]
}

module "s3_lambda_permissions" {
  source = "../../modules/s3_lambda_permissions"
  function_name = module.lamdba_function.function_name
  function_arn = module.lamdba_function.function_arn
  bucket_arn = module.s3_bucket_images.s3_bucket_arn
  bucket_id = module.s3_bucket_images.s3_bucket_id
  depends_on = [module.lamdba_function]
}