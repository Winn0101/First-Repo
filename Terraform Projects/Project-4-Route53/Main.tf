
resource "aws_vpc" "example" {
    cidr_block = "10.0.0.0/16"
  
}
resource "aws_route53_zone" "private" {
  name = "example.web.com"

  vpc {
    vpc_id = aws_vpc.example.id
  }
}

resource "aws_route53_record" "A-Record" {
  zone_id = aws_route53_zone.private.zone_id
  for_each = {
    Record-1 = "www.example.web.com"
    Record-2 = "api.example.web.com"
    Record-3 = "mail.example.web.com"
    Record-4 = "blog.example.web.com"
    Record-5 = "shop.example.web.com"
  }
  name    = each.value
  type    = "A"
  ttl     = 100
  records = ["192.168.0.${substr(each.key, length(each.key) -1, 1)}"]
}

resource "aws_route53_record" "CNAME-Record" {
  zone_id = aws_route53_zone.private.zone_id
  for_each = {
    CNAME-1 = "app1.example.web.com"
    CNAME-2 = "app2.example.web.com"
    CNAME-3 = "edu.example.web.com"
  }
  name    = each.value
  type    = "CNAME"
  ttl     = 80
  records = ["example.web.com"]
}

resource "aws_route53_record" "TXT-Record" {
  zone_id = aws_route53_zone.private.zone_id
  for_each = {
    TXT-1 = "txt1.example.web.com"
    TXT-2 = "txt2.example.web.com"
  }
  name    = each.value
  type    = "TXT"
  ttl     = 120
  records = ["A sample TXT record for ${each.value}"]
}