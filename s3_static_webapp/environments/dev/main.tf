module "s3_public_static_web" {
    source = "../../modules/s3_public_static_web"
    bucket_name = "dev-static-website-1"
    bucket_versioning = "Disabled"
    bucket_tags = {
        Environment = "Dev"
    }
    index_document = "index.html"
    error_document = "error.html"
    copy_source_files = true
    source_files = "../../static_webapp/"
}