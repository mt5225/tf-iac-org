terraform {
  required_version = ">= 0.12.0"
}

resource "aws_iam_role" "iam_role" {
  name = var.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.name
  role = aws_iam_role.iam_role.name
}

data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    effect = "Allow"
    actions = var.actions
    resources = var.resources
  }
}

resource "aws_iam_role_policy" "iam_role_policy" {
  name = var.name
  role = aws_iam_role.iam_role.name
  policy = data.aws_iam_policy_document.iam_policy_document.json
}
