output "alb_dns" {
  value = aws_lb.production.dns_name
}
output "alb_zone" {
  value = aws_lb.production.zone_id
}