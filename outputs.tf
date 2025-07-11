output "vpc_id" {
    value = aws_vpc.main.id
}
output "public_subnets" {
    value = { for key, subnet in aws_subnet.public : key => subnet.id }
}

output "private_subnets" {
    value = { for key, subnet in aws_subnet.private : key => subnet.id }
}

output "database_subnets" {
    value = { for key, subnet in aws_subnet.database : key => subnet.id }
}

