terraform {
  backend "s3" {
    bucket         = "abhi01tf-backend-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "abhi01tf-lock-table"
    encrypt        = true
  }
}