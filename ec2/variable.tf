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
