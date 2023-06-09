# terraform {
#   backend "s3" {
#     bucket = "accproj-1-state"
#     key = "pathh/s3/key/terraform.state"
#     region = "eu-west-2"
#     dynamodb_table = "accproj-1-state-locking"
#     encrypt = true
#   }
# }




#create backend s3 bucket
resource "aws_s3_bucket" "accproj-state" {
  bucket        = "accproj-1-state"
  force_destroy = true
  
#   lifecycle {
#     prevent_destroy = true
#   }

#   versioning {
#     enabled = true
#   }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "accproj-1-state"
  }
}



#DynamoDB Table

resource "aws_dynamodb_table" "terraform-lock" {
  name     = "accproj-1-state-locking"
#   billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"

  }

  write_capacity = 1
  read_capacity  = 1


  tags = {

    Name        = "TF State Lock"
    Environment = "Terraform"

  }

}