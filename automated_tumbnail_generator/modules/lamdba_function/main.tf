data "archive_file" "thumbnail_generator" {
    type = "zip"
    source_dir = "${var.code_path}"
    output_path = "${var.archive_path}"
}


resource "aws_lambda_function" "thumbnail_generator" {
    function_name = var.function_name
    handler = var.handler
    runtime = var.runtime
    filename = data.archive_file.thumbnail_generator.output_path
    role = var.role_arn
    tags = {
        "_custom_name_" = "${var.function_name}-${var.environment}"
    }
    depends_on = [data.archive_file.thumbnail_generator]
}

resource "aws_lambda_function_url" "thumbnail_generator_url" {
    depends_on = [aws_lambda_function.thumbnail_generator]
    function_name = aws_lambda_function.thumbnail_generator.function_name
    authorization_type = "NONE"
}