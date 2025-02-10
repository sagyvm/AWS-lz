terraform {
  backend "s3" {
    bucket         = "terraform-landingzone-state"
    key            = "network/terraform.tfstate"
    region         = "me-central-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
