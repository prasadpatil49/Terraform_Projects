module "s3_bucket_images" {
  source = "../../modules/s3_bucket_images"
  bucket_name = "dev-thumbnail"
  environment = "dev"
}