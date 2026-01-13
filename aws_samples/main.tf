
/*


resource "aws_iam_policy" "adminUsers" {
  name = "AdminUsers"
  policy = file("admin-policy.json")
}


resource "aws_iam_user" "admin-user" {
  name = "prasad"
  tags = {
    Description = "Main admin user"
  }
}

resource "aws_iam_user_policy_attachment" "admin-access" {
    user       = aws_iam_user.admin-user.name
    policy_arn = aws_iam_policy.adminUsers.arn
  
}

resource "aws_s3_bucket" "finance-bucket" {
  bucket = "finance-bucket"
  tags = {
    Description = "Finance and payroll"
  }
}

resource "aws_s3_object" "finance-2025" {
    source = "test-file.txt"
    key     = "test-file.txt"
    bucket  = aws_s3_bucket.finance-bucket.id
    acl = "public-read"
}

*/

resource "aws_dynamodb_table" "cars" {
  name = "cars"
  hash_key = "VIN"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "VIN"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "car-items" {
    table_name = aws_dynamodb_table.cars.name
    hash_key = aws_dynamodb_table.cars.hash_key
    item = <<EOF
    {
        "VIN": {"S":"1234"},
        "Make": {"S": "Toyota"},
        "Model": {"S": "Corolla"},
        "Year": {"N": "2020"},
        "Color": {"S": "Red"}
    }
EOF
  
}