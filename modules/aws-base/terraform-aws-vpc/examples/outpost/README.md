# VPC with Outpost Subnet

Configuration in this directory creates a VPC with public, private, and private outpost subnets.

This configuration uses data-source to find an available Outpost by name. Change it according to your needs in order to run this example.

[Read more about AWS regions, availability zones and local zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.htmloncepts-regions-availability-zones).

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                     | Version    |
| ------------------------------------------------------------------------ | ---------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12.26 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.15    |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 3.15 |

## Modules

| Name                                         | Source | Version |
| -------------------------------------------- | ------ | ------- |
| <a name="module_vpc"></a> [vpc](#module_vpc) | ../../ |         |

## Resources

| Name                                                                                                                                  | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_outposts_outpost.shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/outposts_outpost)        | data source |

## Inputs

No inputs.

## Outputs

| Name                                                                             | Description                                                       |
| -------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| <a name="output_azs"></a> [azs](#output_azs)                                     | A list of availability zones specified as argument to this module |
| <a name="output_nat_public_ips"></a> [nat_public_ips](#output_nat_public_ips)    | List of public Elastic IPs created for AWS NAT Gateway            |
| <a name="output_outpost_subnets"></a> [outpost_subnets](#output_outpost_subnets) | List of IDs of private subnets                                    |
| <a name="output_private_subnets"></a> [private_subnets](#output_private_subnets) | List of IDs of private subnets                                    |
| <a name="output_public_subnets"></a> [public_subnets](#output_public_subnets)    | List of IDs of public subnets                                     |
| <a name="output_vpc_cidr_block"></a> [vpc_cidr_block](#output_vpc_cidr_block)    | The CIDR block of the VPC                                         |
| <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id)                            | The ID of the VPC                                                 |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
