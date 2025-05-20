
terraform {
  backend "s3" {
    bucket = "cdecb36-bucket007"
    key    = "demo/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "my-terra-table780-7"
  }
}