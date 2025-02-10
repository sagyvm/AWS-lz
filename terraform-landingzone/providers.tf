provider "aws" {
  alias  = "networking"
  region = "me-central-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.networking_account_id}:role/TerraformRole"
  }
}

provider "aws" {
  alias  = "application"
  region = "me-central-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.application_account_id}:role/TerraformRole"
  }
}
