# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block] #resources within the vpc will only communicate with our private subnet, You must be in the vpc to talk to our private subnet,
  #this is b/c we have set the ingress cidr block, to be within the vpc only. Our application in this private subnet will be accessed by
  #endusers via our LB in the public subnet. Since the LB is in the public subnet, it is within the vpc.
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}

