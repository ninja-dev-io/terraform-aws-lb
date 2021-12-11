output "target_groups" {
  value = zipmap(var.target_groups[*].name, values(aws_alb_target_group.target_groups)[*].arn)
}
