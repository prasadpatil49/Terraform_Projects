variable "function_name" {
  type = string
  default = "thumbnail-generator"
}

variable "environment" {
  type = string
}

variable "handler" {
  type = string
  default = "python_lambda.lambda_handler"
}

variable "runtime" {
  type = string
  default = "python3.10"
}

variable "code_path" {
  type = string
}
variable "archive_path" {
  type = string
}
# local stack default role
variable "role_arn" {
  type = string
  default = "arn:aws:iam::000000000000:role/lambda-role"
}
