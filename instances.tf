resource "aws_instance" "webservers" {
  count           = length(var.public_subnets_cidr)
  subnet_id       = element(aws_subnet.public.*.id, count.index)
  ami             = var.webservers_ami
  instance_type   = var.instance_type
  key_name        = var.keyname
  security_groups = ["${aws_security_group.webservers.id}"]

  tags = {
    Name = "Web-Server-${count.index}"
  }
}


# output "ip" {
#   value = aws_instance.webservers.*.public_ip
# }

# output "webservers" {
#   value = "${aws_instance.webservers.*.public_ip}"
# }

