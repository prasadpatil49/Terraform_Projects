output "lambda_function_url" {
  value = aws_lambda_function_url.thumbnail_generator_url.function_url
}

output "function_arn" {
  value = aws_lambda_function.thumbnail_generator.arn
}

output "function_name" {
  value = aws_lambda_function.thumbnail_generator.function_name
}