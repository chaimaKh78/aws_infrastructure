variable "alb_name" {
  description = "Nom de l'ALB"
  type        = string
}

variable "alb_internal" {
  description = "Indique si l'ALB est interne (true) ou internet-facing (false)"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Liste des IDs des subnets"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Liste des IDs des security groups"
  type        = list(string)
}

variable "target_instances" {
  description = "Liste des instances à attacher au target group"
  type = list(object({
    id   = string
    port = number
  }))
}

variable "listener_port" {
  description = "Port écouté par l'ALB"
  type        = number
  default     = 80
}
