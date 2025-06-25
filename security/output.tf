output "private_security_group_id" {
value = aws_security_group.private_sg.id  
}
output "security_group_ids" {
value =  aws_security_group.public_sg.id  
}