terraform {
  backend "s3" {
    bucket         = "babu-terraform-state-apse2"
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
