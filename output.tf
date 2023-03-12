#### Defining outputs from resources
# aws_vpc" "terra_vpc
output "vpc_id" {
  value = aws_vpc.terra_vpc.id
}

# elb name
output "elb-dns-id" {
  value = aws_elb.terra-elb.arn
}

# web server ips
output "ip" {
  value = aws_instance.webservers.*.public_ip
}


output "database-instance" {
  value     = aws_db_instance.db_instance
  sensitive = true
}