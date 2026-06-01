terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-nazzy812"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}