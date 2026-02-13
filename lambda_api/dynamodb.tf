resource "aws_dynamodb_table" "application_table" {
  name = "users"
  hash_key = "id"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Name = "users"
  }
}

