output "target_groups" {
  value = zipmap(keys(aws_alb_target_group.target_groups), values(aws_alb_target_group.target_groups)[*].arn)
}
