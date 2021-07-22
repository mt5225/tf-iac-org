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
      name = "demo"
      type = "A"
      ttl  = 3600
      records = [
        module.cloudiac.public_ip
      ]
    },
  ]
}
