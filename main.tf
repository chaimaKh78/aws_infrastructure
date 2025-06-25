terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~>3.0"
        }
    }   
}

provider "aws" {
    region = "us-east-1"
}
data "aws_ami" "test" {
    name = "test"
  
}

module "vpc" {
    source = "./network"
    vpc_cidr_block  = var.vpc_cidr_block
    subnets         = var.subnets  
}
module "security" {
    source = "./security"
    public_sg_name = var.public_sg_name
    private_sg_name = var.private_sg_name
    public_nacl_name = var.public_nacl_name
    internal_communication_cidr = var.internal_communication_cidr
    private_nacl_name = var.private_nacl_name  
}
module "ec2_instances" {
  source             = "./ec2"
  instance_count     = var.instance_count
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_id  = module.security.private_security_group_id
}

locals {
  target_instances = [
    for id in module.ec2_instances.instances : {
      id   = id
      port = 80
    }
  ]
}
module "alb" {
  source             = "./loadbalancer"
  alb_name           = "web-alb"
  alb_internal       = false
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security.security_group_ids]
  target_instances   = local.target_instances
}
module "lambda_snapshot_cleaner" {
  source          = "./modules/lambda_snapshot_cleaner"
  retention_days  = 7
  function_name   = "ebs-snapshot-cleaner"
}

