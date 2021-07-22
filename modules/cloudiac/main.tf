data "cloudinit_config" "config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = file("${path.module}/cloud_config.yaml")
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

module "ec2" {
  source         = "terraform-aws-modules/ec2-instance/aws"
  instance_count = 1

  name                        = "cloudiam"
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.large"
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg.websvr]
  associate_public_ip_address = true
  key_name                    = var.ssh_keypair

  user_data_base64 = data.cloudinit_config.config.rendered

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 64
    },
  ]
  tags = {
    "Env"      = "demo"
    "Location" = "Secret"
    "Role"     = "cloudiac"
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name = "cloudiac.org"
  zone_id     = "Z0688329235ZOA5FIEND9"

  subject_alternative_names = [
    "*.cloudiac.org",
  ]

  wait_for_validation = true

  tags = {
    Name = "cloudiac.org"
  }
}


module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "cloudiac-alb"

  load_balancer_type = "application"

  vpc_id          = var.vpc.vpc_id
  subnets         = var.vpc.public_subnets
  security_groups = [var.sg.lb]

  target_groups = [
    {
      name_prefix      = "iac-"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
      targets = [
        {
          target_id = module.ec2.id[0]
          port      = 8080
        },
      ]
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.acm_certificate_arn
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "demo"
  }
}
