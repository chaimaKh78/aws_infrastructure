variable "ec2_name" {
  type        = string
  description = "Nom de l'instance EC2"
  default     = "private-ec2"
}

variable "ec2_ami_id" {
  type        = string
  description = "AMI à utiliser pour l'instance EC2"
}

variable "ec2_instance_type" {
  type        = string
  description = "Type d'instance EC2"
}
variable "ec2_private_subnet_key" {
  type        = string
  description = "Nom du subnet privé pour cette EC2"
}
variable "vpc_security_group_ids" {
  type = string
}
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
variable "instance_count" {
  type    = number
  default = 2
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}