# ACM Module - To create and Verify SSL Certificates
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "2.14.0"
#The trimsuffix is added to remove any dot "." in the internal domain
  domain_name  = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  zone_id      = data.aws_route53_zone.mydomain.zone_id 

  subject_alternative_names = [
    "*.wiz-obi.com"
  ]
  tags = local.common_tags
}

# Output ACM Certificate ARN
output "this_acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.this_acm_certificate_arn
}

