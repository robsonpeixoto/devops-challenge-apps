output "alb_api_dns_name" {
  value = "${module.api.alb_dns_name}"
}

output "alb_web_dns_name" {
  value = "${module.web.alb_dns_name}"
}
