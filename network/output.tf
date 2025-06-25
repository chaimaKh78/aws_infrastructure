output "public_subnet_ids" {
value = aws_subnet.subnets.id 
}
output "vpc_id" {
value = aws_vpc.myvpc.id  
}
