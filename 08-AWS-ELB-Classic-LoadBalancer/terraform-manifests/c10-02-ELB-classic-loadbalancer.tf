# Terraform AWS Classic Load Balancer (ELB-CLB)
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "2.5.0"
  name = "${local.name}-myelb"
  subnets         = [
    module.vpc.public_subnets[0], #The elb is been created in the public subnet in 2 azs for high availability
    module.vpc.public_subnets[1]
  ]
  security_groups = [module.loadbalancer_sg.this_security_group_id]
  #internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 81
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  # ELB attachments
  number_of_instances = var.private_instance_count
  instances           = [
    module.ec2_private.id[0], #THE ELB is targeting our instances in the private subnet and resolving traffic to them via dns resolution.
    module.ec2_private.id[1]
  ] #we can add depends_on here but it cant be used all the time b/c 95% of the time terraform handles this.
  tags = local.common_tags
}