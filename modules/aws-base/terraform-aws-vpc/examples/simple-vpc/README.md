# Simple VPC

Configuration in this directory creates set of VPC resources which may be sufficient for development environment.

There is a public and private subnet created per availability zone in addition to single NAT Gateway shared between all 3 availability zones.

This configuration uses Availability Zone IDs and Availability Zone names for demonstration purposes. Normally, you need to specify only names or IDs.

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

No providers.

## Modules

| Name                                         | Source | Version |
| -------------------------------------------- | ------ | ------- |
| <a name="module_vpc"></a> [vpc](#module_vpc) | ../../ |         |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name                                                                             | Description                                                       |
| -------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| <a name="output_azs"></a> [azs](#output_azs)                                     | A list of availability zones spefified as argument to this module |
| <a name="output_nat_public_ips"></a> [nat_public_ips](#output_nat_public_ips)    | List of public Elastic IPs created for AWS NAT Gateway            |
| <a name="output_private_subnets"></a> [private_subnets](#output_private_subnets) | List of IDs of private subnets                                    |
| <a name="output_public_subnets"></a> [public_subnets](#output_public_subnets)    | List of IDs of public subnets                                     |
| <a name="output_vpc_cidr_block"></a> [vpc_cidr_block](#output_vpc_cidr_block)    | The CIDR block of the VPC                                         |
| <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id)                            | The ID of the VPC                                                 |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
