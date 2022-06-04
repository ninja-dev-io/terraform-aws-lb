resource "aws_lb_listener_rule" "forward_rules" {
  for_each     = { for index, rule in var.forward_rules : "${index}" => rule }
  listener_arn = lookup(aws_lb_listener.lb_listener, each.value.listener).arn
  priority     = each.value.priority
  action {
    type             = "forward"
    target_group_arn = lookup(aws_alb_target_group.target_groups, each.value.target_group).arn
  }
  dynamic "condition" {
    for_each = each.value.condition
    content {
      dynamic "path_pattern" {
        for_each = condition.value.path_pattern
        content {
          values = path_pattern.value.values
        }
      }
      dynamic "host_header" {
        for_each = condition.value.host_header
        content {
          values = host_header.value.values
        }
      }
      dynamic "http_header" {
        for_each = condition.value.http_header
        content {
          http_header_name = http_header.value.http_header_name
          values           = http_header.value.values
        }
      }
      dynamic "query_string" {
        for_each = condition.value.query_string
        content {
          key   = query_string.value.key
          value = query_string.value.value
        }
      }
    }
  }
}

resource "aws_lb_listener_rule" "forward_weighted_rules" {
  for_each     = { for index, rule in var.forward_weighted_rules : "${index}" => rule }
  listener_arn = lookup(aws_lb_listener.lb_listener, each.value.listener).arn
  priority     = each.value.priority
  action {
    type = "forward"
    forward {
      dynamic "target_group" {
        for_each = each.value.target_groups
        content {
          arn    = lookup(aws_alb_target_group.target_groups, target_group.value.name).arn
          weight = target_group.value.weight
        }
      }
      stickiness {
        enabled  = each.value.stickiness.enabled
        duration = each.value.stickiness.duration
      }
    }
  }
  dynamic "condition" {
    for_each = each.value.condition
    content {
      dynamic "path_pattern" {
        for_each = condition.value.path_pattern
        content {
          values = path_pattern.value.values
        }
      }
      dynamic "host_header" {
        for_each = condition.value.host_header
        content {
          values = host_header.value.values
        }
      }
      dynamic "http_header" {
        for_each = condition.value.http_header
        content {
          http_header_name = http_header.value.http_header_name
          values           = http_header.value.values
        }
      }
      dynamic "query_string" {
        for_each = condition.value.query_string
        content {
          key   = query_string.value.key
          value = query_string.value.value
        }
      }
    }
  }
}

resource "aws_lb_listener_rule" "redirect_rules" {
  for_each     = { for index, rule in var.redirect_rules : "${index}" => rule }
  listener_arn = lookup(aws_lb_listener.lb_listener, each.value.listener).arn
  action {
    type = "redirect"
    redirect {
      port        = each.value.redirect.port
      protocol    = each.value.redirect.protocol
      status_code = each.value.redirect.status_code
    }
  }
  dynamic "condition" {
    for_each = each.value.condition
    content {
      dynamic "path_pattern" {
        for_each = condition.value.path_pattern
        content {
          values = path_pattern.value.values
        }
      }
      dynamic "host_header" {
        for_each = condition.value.host_header
        content {
          values = host_header.value.values
        }
      }
      dynamic "http_header" {
        for_each = condition.value.http_header
        content {
          http_header_name = http_header.value.http_header_name
          values           = http_header.value.values
        }
      }
      dynamic "query_string" {
        for_each = condition.value.query_string
        content {
          key   = query_string.value.key
          value = query_string.value.value
        }
      }
    }
  }
}

resource "aws_lb_listener_rule" "fixed_response_rules" {
  for_each     = { for index, rule in var.fixed_response_rules : "${index}" => rule }
  listener_arn = lookup(aws_lb_listener.lb_listener, each.value.listener).arn
  action {
    type = "fixed-response"
    fixed_response {
      content_type = each.value.fixed_response.content_type
      message_body = each.value.fixed_response.message_body
      status_code  = each.value.fixed_response.status_code
    }
  }
  dynamic "condition" {
    for_each = each.value.condition
    content {
      dynamic "path_pattern" {
        for_each = condition.value.path_pattern
        content {
          values = path_pattern.value.values
        }
      }
      dynamic "host_header" {
        for_each = condition.value.host_header
        content {
          values = host_header.value.values
        }
      }
      dynamic "http_header" {
        for_each = condition.value.http_header
        content {
          http_header_name = http_header.value.http_header_name
          values           = http_header.value.values
        }
      }
      dynamic "query_string" {
        for_each = condition.value.query_string
        content {
          key   = query_string.value.key
          value = query_string.value.value
        }
      }
    }
  }
}
