terraform {
  backend "s3" {
    bucket = "accproj-1-state"
    key = "pathh/s3/key/terraform.state"
    region = "eu-west-2"
    dynamodb_table = "accproj-1-state-locking"
    encrypt = true
  }
}