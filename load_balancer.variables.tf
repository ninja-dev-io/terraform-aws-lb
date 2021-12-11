variable "lb" {
  type = object({
    name                       = string
    internal                   = bool
    load_balancer_type         = string
    security_groups            = list(string)
    subnets                    = list(string)
    enable_deletion_protection = bool
  })
}

variable "lb_listeners" {
  type = list(object({
    name            = string
    port            = number
    protocol        = string
    ssl_policy      = string
    certificate_arn = string
    default_action = list(object({
      type         = string
      target_group = string
      redirect = list(object({
        port        = string
        protocol    = string
        status_code = string
      }))
      fixed_response = list(object({
        content_type = string
        message_body = string
        status_code  = string
      }))
    }))
  }))
}

variable "target_groups" {
  type = list(object({
    name        = string
    port        = number
    protocol    = string
    target_type = string
    health_check = list(object({
      healthy_threshold   = string
      interval            = string
      protocol            = string
      matcher             = string
      timeout             = string
      path                = string
      unhealthy_threshold = string
    }))
  }))
}
