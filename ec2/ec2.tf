resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)
  security_groups = [var.security_group_id]

  tags = {
    Name         = "${count.index}"
    BackupPolicy = "daily"
  }

  root_block_device {
    volume_size = 8
    tags = {
      BackupPolicy = "daily"
    }
  }
}
