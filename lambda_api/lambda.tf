data "aws_iam_policy_document" "application_lambda_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_dynamodb_policy" {
  statement {
    sid= "AllowDynamoDBAccess"
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query"
    ]
    resources = [
      aws_dynamodb_table.application_table.arn
    ]
  }
  statement {
    sid= "AllowLambdaLogging"
    effect = "Allow"
    actions = [ 
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
     ]
    resources = [ 
      "arn:aws:logs:*:*:*"
     ]
  }
}

resource "aws_iam_role" "application_lambda_role" {
  name               = "${var.application_name}-${var.environment}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.application_lambda_role.json
}

resource "aws_iam_role_policy" "lambda_dynamodb_access" {
  name   = "${var.application_name}-${var.environment}-lambda-dynamodb-policy"
  role   = aws_iam_role.application_lambda_role.id
  policy = data.aws_iam_policy_document.lambda_dynamodb_policy.json
}


resource "aws_lambda_function" "application_lambda" {
  function_name = "${var.application_name}-${var.environment}-lambda"
  handler = "main.handler"
  runtime = "python3.11"
  filename = "python_app.zip"
  layers = [ "arn:aws:lambda:us-east-1:017000801446:layer:AWSLambdaPowertoolsPythonV2:47" ]
  role = aws_iam_role.application_lambda_role.arn
  tags = {
    Name = "${var.application_name}-${var.environment}-lambda"
  }
}

