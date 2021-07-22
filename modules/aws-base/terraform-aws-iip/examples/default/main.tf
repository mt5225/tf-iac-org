
module "iam_instance_profile_default" {
  source = "../../"
}


module "iam_instance_profile_optional_attributes" {
  source  = "../../"
  name    = "test"
  actions = ["logs:*", "s3:*", "rds:*"]
}

