# SG - Subnets Publics
resource "aws_security_group" "public_sg" {
  name        = var.public_sg_name
  description = "Allow SSH, HTTP and HTTPS from the Internet"
  vpc_id      = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = var.public_sg_ports
    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.public_ingress_cidr_blocks
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_sg_name
  }
}

# SG - Subnets Privés
resource "aws_security_group" "private_sg" {
  name        = var.private_sg_name
  description = "Allow traffic from public SG"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description     = "Allow traffic from public SG"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.private_sg_name
  }
}

# NACL Public
resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.myvpc.id

  subnet_ids = [
    for k, subnet in aws_subnet.subnets :
    subnet.id if subnet.tags["Type"] == "public"
  ]

  dynamic "ingress" {
    for_each = var.public_nacl_ports
    content {
      protocol   = "tcp"
      rule_no    = ingress.key
      action     = "allow"
      cidr_block = var.public_ingress_cidr_blocks[0]
      from_port  = ingress.value
      to_port    = ingress.value
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = var.public_nacl_name
  }
}

# NACL Privé
resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.myvpc.id

  subnet_ids = [
    for k, subnet in aws_subnet.subnets :
    subnet.id if subnet.tags["Type"] == "private"
  ]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.internal_communication_cidr
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = var.private_nacl_name
  }
}


