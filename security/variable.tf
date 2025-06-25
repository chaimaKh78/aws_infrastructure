variable "public_sg_name" {
  type        = string
  description = "Nom du security group public"
}

variable "private_sg_name" {
  type        = string
  description = "Nom du security group privé"
}

variable "public_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDRs autorisés à accéder aux instances publiques (ex: SSH, HTTP, HTTPS)"
  default     = ["0.0.0.0/0"]
}

variable "public_sg_ports" {
  type        = list(number)
  description = "Ports à ouvrir dans le SG public (ex: [22, 80, 443])"
  default     = [22, 80, 443]
}

variable "public_nacl_ports" {
  type        = map(number)
  description = "Map des règles NACL public (clé = numéro de règle, valeur = port)"
  default = {
    100 = 22
    110 = 80
    120 = 443
  }
}

variable "public_nacl_name" {
  type        = string
  description = "Nom du NACL pour les subnets publics"
}

variable "private_nacl_name" {
  type        = string
  description = "Nom du NACL pour les subnets privés"
}

variable "internal_communication_cidr" {
  type        = string
  description = "CIDR utilisé pour les communications internes dans le VPC"
}
