#Generate certificate
resource "aws_acm_certificate" "ac-project" {
    domain_name = "thegattag.com"
    validation_method = "DNS"

    tags = {
      "Environment" = "ac-project"
    }

    lifecycle {
      create_before_destroy = true
    }
}

#obtain details of R53 hosted zone
data "aws_route53_zone" "ac-project-r53-zone" {
    name = "thegattag.com"
    private_zone = false
}

#record set r53 domain name validation
resource "aws_route53_record" "ac-project-record" {
    for_each = {
      for dnm in aws_acm_certificate.ac-project.domain_validation_options: dnm.domain_name =>{
        name = dnm.resource_record_name
        record = dnm.resource_record_value
        type = dnm.resource_record_type
      }
    }

    allow_overwrite = true
    name = each.value.name
    records = [each.value.record]
    ttl = 60
    type = each.value.type
    zone_id = data.aws_route53_zone.ac-project-r53-zone.id
}

#validate acm certificate
resource "aws_acm_certificate_validation" "acm_cert_validation" {
    certificate_arn = aws_acm_certificate.ac-project.arn
    validation_record_fqdns = [ for record in aws_route53_record.ac-project-record : record.fqdn] #for any fully qualified domain name in this record above, pls sign it for me
  
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.ac-project-r53-zone.zone_id
  name = "thegattag.com"
  type = "A"

  alias{
    name = var.docker-prod-lb-dns
    zone_id = var.docker-prod-lb-zone-id
    evaluate_target_health = true
  }
  
}

