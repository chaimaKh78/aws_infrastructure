output "alb_dns_name" {
  description = "Le DNS de l'ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}
