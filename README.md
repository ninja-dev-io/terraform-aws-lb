# terraform-aws-lb
lb IaC

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb_target_group.target_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.fixed_response_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.forward_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.redirect_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authenticate_cognito_rules"></a> [authenticate\_cognito\_rules](#input\_authenticate\_cognito\_rules) | n/a | <pre>list(object({<br>    listener = string<br>    authenticate_cognito = object({<br>      user_pool_arn       = string<br>      user_pool_client_id = string<br>      user_pool_domain    = string<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_authenticate_oidc_rules"></a> [authenticate\_oidc\_rules](#input\_authenticate\_oidc\_rules) | n/a | <pre>list(object({<br>    listener               = string<br>    authorization_endpoint = string<br>    client_id              = string<br>    client_secret          = string<br>    issuer                 = string<br>    token_endpoint         = string<br>    user_info_endpoint     = string<br>  }))</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_fixed_response_rules"></a> [fixed\_response\_rules](#input\_fixed\_response\_rules) | n/a | <pre>list(object({<br>    listener = string<br>    fixed_response = object({<br>      content_type = string<br>      message_body = string<br>      status_code  = string<br>    })<br>    condition = object({<br>      query_string = list(object({<br>        key   = string<br>        value = string<br>      }))<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_forward_rules"></a> [forward\_rules](#input\_forward\_rules) | n/a | <pre>list(object({<br>    listener = string<br>    priority = number<br>    target_groups = list(object({<br>      name   = string<br>      weight = number<br>    }))<br>    stickiness = object({<br>      enabled  = bool<br>      duration = number<br>    })<br>    condition = object({<br>      host_header = object({<br>        values = list(string)<br>      })<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_lb"></a> [lb](#input\_lb) | n/a | <pre>object({<br>    name                       = string<br>    internal                   = bool<br>    load_balancer_type         = string<br>    security_groups            = list(string)<br>    subnets                    = list(string)<br>    enable_deletion_protection = bool<br>  })</pre> | n/a | yes |
| <a name="input_lb_listeners"></a> [lb\_listeners](#input\_lb\_listeners) | n/a | <pre>list(object({<br>    name            = string<br>    port            = number<br>    protocol        = string<br>    ssl_policy      = string<br>    certificate_arn = string<br>    default_action = list(object({<br>      type         = string<br>      target_group = string<br>      redirect = list(object({<br>        port        = string<br>        protocol    = string<br>        status_code = string<br>      }))<br>      fixed_response = list(object({<br>        content_type = string<br>        message_body = string<br>        status_code  = string<br>      }))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_redirect_rules"></a> [redirect\_rules](#input\_redirect\_rules) | n/a | <pre>list(object({<br>    listener = string<br>    redirect = object({<br>      port        = string<br>      protocol    = string<br>      status_code = string<br>    })<br>    condition = object({<br>      http_header = list(object({<br>        http_header_name = string<br>        values           = list(string)<br>      }))<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | `map(string)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `map(string)` | n/a | yes |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | n/a | <pre>list(object({<br>    name        = string<br>    port        = number<br>    protocol    = string<br>    target_type = string<br>    health_check = list(object({<br>      healthy_threshold   = string<br>      interval            = string<br>      protocol            = string<br>      matcher             = string<br>      timeout             = string<br>      path                = string<br>      unhealthy_threshold = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_target_groups"></a> [target\_groups](#output\_target\_groups) | n/a |
<!-- END_TF_DOCS -->