# DNS Registration 
## Default DNS
resource "aws_route53_record" "default_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id #zone_id For route 53
  name    = "myapps"
  type    = "A"
  alias {
    name                   = module.alb.this_lb_dns_name #ALB DNS NAME
    zone_id                = module.alb.this_lb_zone_id #The zone_id of the load balancer to assist with creating DNS records.
    evaluate_target_health = true
  }  
}

## App1 DNS
resource "aws_route53_record" "app1_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id 
  name    = var.app1_dns_name
  type    = "A"
  alias {
    name                   = module.alb.this_lb_dns_name
    zone_id                = module.alb.this_lb_zone_id
    evaluate_target_health = true
  }  
}


## App2 DNS
resource "aws_route53_record" "app2_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id 
  name    = var.app2_dns_name
  type    = "A"
  alias {
    name                   = module.alb.this_lb_dns_name
    zone_id                = module.alb.this_lb_zone_id
    evaluate_target_health = true
  }  
}