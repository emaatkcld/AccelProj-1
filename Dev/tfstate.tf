terraform {
  backend "s3" {
    bucket = "accel-proj-1-state"
    key = "global/s3/key/terraform.state"
    region = "eu-west-2"
    dynamodb_table = "accel-proj-1-state-locking"
    encrypt = true
  }
}