module "cloudiac" {
  source      = "./modules/cloudiac"
  namespace   = var.namespace
  ssh_keypair = var.ssh_keypair

  vpc = module.networking.vpc
  sg  = module.networking.sg
}

module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

module "dns-records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = "cloudiac.org"

  records = [
    {
      name = "iac01"
      type = "A"
      ttl  = 3600
      records = [
        module.cloudiac.public_ip
      ]
    },
    {
      name           = "demo"
      type           = "CNAME"
      ttl            = 5
      set_identifier = "iac-lb"
      records = [
        module.cloudiac.lb_dns_name
      ]
      weighted_routing_policy = {
        weight = 100
      }
    },
  ]
}
