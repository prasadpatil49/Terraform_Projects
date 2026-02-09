resource "aws_lambda_permission" "allow_bucket_access" {
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  function_name = var.function_name
  principal = "s3.amazonaws.com"
  source_arn = var.bucket_arn
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket_id
  lambda_function {
    lambda_function_arn = var.function_arn
    events = ["s3:ObjectCreated:*"]
    filter_prefix = "images/"
  }

}

