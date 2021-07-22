# terraform-aws-iam_instance_profile
This module creates an `iam_instance_profile` based on provided allowed actions and resources. The module is built for Terraform version 0.12

## Examples
See also [/examples/default] a complete working example.


## Usages
```
module "iam_instance_profile" {
    name = var.name
    actions = [
        "s3:*",
        "rds:*",
        "logs:*",
    ]
}

##
```

## Outputs:
The name of the iam_instance_profile: `module.iam_instance_profile.name`