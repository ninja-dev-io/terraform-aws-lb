variable "redirect_rules" {
  type = list(object({
    listener = string
    redirect = object({
      port        = string
      protocol    = string
      status_code = string
    })
    condition = list(object({
      host_header = list(object({
        values = list(string)
      }))
      http_header = list(object({
        http_header_name = string
        values           = list(string)
      }))
      query_string = list(object({
        key   = string
        value = string
      }))
    }))
  }))
}

variable "forward_rules" {
  type = list(object({
    listener = string
    priority = number
    target_groups = list(object({
      name   = string
      weight = number
    }))
    stickiness = object({
      enabled  = bool
      duration = number
    })
    condition = list(object({
      host_header = list(object({
        values = list(string)
      }))
      http_header = list(object({
        http_header_name = string
        values           = list(string)
      }))
      query_string = list(object({
        key   = string
        value = string
      }))
    }))
  }))
}

variable "fixed_response_rules" {
  type = list(object({
    listener = string
    fixed_response = object({
      content_type = string
      message_body = string
      status_code  = string
    })
    condition = list(object({
      host_header = list(object({
        values = list(string)
      }))
      http_header = list(object({
        http_header_name = string
        values           = list(string)
      }))
      query_string = list(object({
        key   = string
        value = string
      }))
    }))
  }))
}

variable "authenticate_cognito_rules" {
  type = list(object({
    listener = string
    authenticate_cognito = object({
      user_pool_arn       = string
      user_pool_client_id = string
      user_pool_domain    = string
    })
  }))
}

variable "authenticate_oidc_rules" {
  type = list(object({
    listener               = string
    authorization_endpoint = string
    client_id              = string
    client_secret          = string
    issuer                 = string
    token_endpoint         = string
    user_info_endpoint     = string
  }))
}
