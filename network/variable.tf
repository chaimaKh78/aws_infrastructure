variable "vpc_cidr_block" {
  type        = string
  description = "Le bloc CIDR de base à utiliser pour créer le VPC "
}

variable "subnets" {
  type = map(object({
    cidr = string      
    az   = string     
    type = string     
  }))
  }