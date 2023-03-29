terraform {
  backend "s3" {
    bucket         = "devops-training-terraform-tf"
    key            = "remote_state/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf-dynamoDB"
  }
}