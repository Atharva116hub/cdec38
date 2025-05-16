provider "aws" {
  # Configuration options
  region = "eu-west-2"
}


module "my-vpc_basics" {
    source = "./module/vpc"
  
}