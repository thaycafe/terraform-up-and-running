provider "aws" {
  region = "us-east-2"
}


terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-thay"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}


data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "terraform-up-and-running-state-thay"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
  }
}