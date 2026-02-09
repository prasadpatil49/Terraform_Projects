resource "aws_s3_bucket" "images_bucket" {
  bucket = "${var.bucket_name}-images"
  tags = {
    Name = "${var.bucket_name}-images"
    Environment = var.environment
  }
}

resource "aws_s3_object" "images_object" {
  for_each = toset(["images/", "thumbnails/"])
  bucket = aws_s3_bucket.images_bucket.id
  key = each.value
}