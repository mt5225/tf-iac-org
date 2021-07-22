output "public_ip" {
  value = module.ec2.public_ip[0]
}

output "lb_dns_name" {
  value = module.alb.lb_dns_name
}
