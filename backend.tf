terraform {
  backend "s3" {
    bucket = "minatfstatebucket"
    key    = "mina/tfstate.tf"
    region = "us-east-1"
    dynamodb_table= "lock-tfstate-dynamodb"
  }
}
