# # configured aws provider with proper credentials
# provider "aws" {
#   region  = 
#   profile = 
# }


# # create default vpc if one does not exit
# resource "aws_default_vpc" "default_vpc" {

#   tags = {
#     Name = "default vpc"
#   }
# }


# use data source to get all avalablility zones in region
# data "aws_availability_zones" "available_zones" {}


# create a default subnet in the first az if one does not exit
# resource "aws_default_subnet" "subnet_az1" {
#   availability_zone = 
# }

# # create a default subnet in the second az if one does not exit
# resource "aws_default_subnet" "subnet_az2" {
#   availability_zone = 
# }

# # create security group for the web server
# resource "aws_security_group" "webserver_security_group" {
#   name        = "webserver security group"
#   description = "enable http access on port 80"
#   vpc_id      = var.vpc_cidr

#   ingress {
#     description      = "http access"
#     from_port        = 
#     to_port          = 
#     protocol         = 
#     cidr_blocks      = 
#   }

#   egress {
#     from_port        = 
#     to_port          = 
#     protocol         = 
#     cidr_blocks      = 
#   }

#   tags   = {
#     Name = 
#   }
# }

# create security group for the database
# resource "aws_security_group" "database_security_group" {
#   name        = "database security group"
#   description = "enable mysql/aurora access on port 3306"
#   vpc_id      = var.vpc_cidr

#   ingress {
#     description      = "mysql/aurora access"
#     from_port        = 
#     to_port          = 
#     protocol         = 
#     security_groups  = 
#   }

#   egress {
#     from_port        = 
#     to_port          = 
#     protocol         = 
#     cidr_blocks      = 
#   }

#   tags   = {
#     Name = 
#   }
# }


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "database-subnets"
  subnet_ids  = [aws_subnet.private[0].id, aws_subnet.private[1].id]
  description = "subnets for database instance"

  tags = {
    Name = "database subnet groups"
  }
}


# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                 = "mysql"
  engine_version         = "8.0.31"
  multi_az               = true
  identifier             = var.database_instance_identifier
  username               = var.database_username
  password               = var.database_password
  instance_class         = var.database_instance_class
  allocated_storage      = "200"
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.id
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  count                  = length(var.private_subnets_cidr)
  #subnet_id       = element(aws_subnet.private.*.id, count.index)
  # availability_zone      = ["${var.azs.}"]
  db_name             = var.database_name
  skip_final_snapshot = "true"
}