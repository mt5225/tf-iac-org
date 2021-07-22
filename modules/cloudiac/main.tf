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
