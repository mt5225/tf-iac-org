terraform {
  backend "s3" {
    bucket = "tf-state-iac"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
