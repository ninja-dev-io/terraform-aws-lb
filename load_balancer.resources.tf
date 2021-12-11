resource "aws_lb" "lb" {
  name                       = "${var.lb.name}-alb-${var.env}"
  internal                   = var.lb.internal
  load_balancer_type         = var.lb.load_balancer_type
  security_groups            = [for group in var.lb.security_groups : lookup(var.security_groups, group)]
  subnets                    = [for subnet in var.lb.subnets : lookup(var.subnets, subnet)]
  enable_deletion_protection = var.lb.enable_deletion_protection
}

resource "aws_lb_listener" "lb_listener" {
  for_each          = { for listener in var.lb_listeners : listener.name => listener }
  load_balancer_arn = aws_lb.lb.id
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = each.value.ssl_policy
  certificate_arn   = each.value.certificate_arn
  tags              = { Name = "lb-listener-${var.env}-${index(var.lb_listeners[*].name, each.value.name) + 1}" }
  dynamic "default_action" {
    for_each = each.value.default_action
    content {
      type             = default_action.value.type
      target_group_arn = lookup(aws_alb_target_group.target_groups, default_action.value.target_group).arn
      dynamic "redirect" {
        for_each = default_action.value.redirect
        content {
          port        = redirect.value.port
          protocol    = redirect.value.protocol
          status_code = redirect.value.status_code
        }
      }
      dynamic "fixed_response" {
        for_each = default_action.value.fixed_response
        content {
          content_type = fixed_response.value.content_type
          message_body = fixed_response.value.message_body
          status_code  = fixed_response.value.status_code
        }
      }
    }
  }
}

resource "aws_alb_target_group" "target_groups" {
  for_each    = { for group in var.target_groups : group.name => group }
  name        = "${each.key}-tg-${var.env}"
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = var.vpc_id
  target_type = each.value.target_type
  dynamic "health_check" {
    for_each = each.value.health_check
    content {
      healthy_threshold   = health_check.value.healthy_threshold
      interval            = health_check.value.interval
      protocol            = health_check.value.protocol
      matcher             = health_check.value.matcher
      timeout             = health_check.value.timeout
      path                = health_check.value.path
      unhealthy_threshold = health_check.value.unhealthy_threshold
    }
  }
}

