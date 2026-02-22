resource "aws_s3_bucket" "s3_bucket" {
    bucket = var.bucket_name
    tags = var.bucket_tags
}


resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
    bucket = aws_s3_bucket.s3_bucket.id
    block_public_acls = true
    block_public_policy = false
    ignore_public_acls = true
    restrict_public_buckets = false
}

data "aws_iam_policy_document" "allow_read_access_all" {
  
  statement {

    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = [ "*" ]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "bucket_readall_policy" {
    bucket = aws_s3_bucket.s3_bucket.id
    policy = data.aws_iam_policy_document.allow_read_access_all.json
    depends_on = [ aws_s3_bucket_public_access_block.s3_bucket_public_access_block ]
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
    bucket = aws_s3_bucket.s3_bucket.id
    versioning_configuration {
        status = var.bucket_versioning
    }
}

resource "aws_s3_bucket_website_configuration" "s3_bucket_website_configuration" {
    bucket = aws_s3_bucket.s3_bucket.id
    index_document {
        suffix = var.index_document
    }
    error_document {
        key = var.error_document
    }

    # routing_rule {
    #     condition {
    #         key_prefix_equals = "docs/"
    #     }
    #     redirect {
    #         replace_key_with = "docs/index.html"
    #     }
    # }

    
}

locals {
  site_dir = var.source_files
  files    = fileset(local.site_dir, "**")
}

resource "aws_s3_object" "copy_source_files" {
  depends_on = [ aws_s3_bucket_website_configuration.s3_bucket_website_configuration, aws_s3_bucket.s3_bucket]
  for_each = local.files    

  bucket = aws_s3_bucket.s3_bucket.id
  key    = each.value
  source = "${local.site_dir}/${each.value}"
  etag   = filemd5("${local.site_dir}/${each.value}")
  content_type = lookup(
    {
      "html" = "text/html"
      "css"  = "text/css"
      "js"   = "application/javascript"
      "png"  = "image/png"
      "jpg"  = "image/jpeg"
      "jpeg" = "image/jpeg"
      "svg"  = "image/svg+xml"
      "txt"  = "text/plain"
      "json" = "application/json"
    },
    lower(regex("\\.([^.]+)$", each.value)[0]),
    "application/octet-stream"
  )
}

