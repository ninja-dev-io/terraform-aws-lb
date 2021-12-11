variable "env" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = map(string)
}

variable "security_groups" {
  type = map(string)
}
