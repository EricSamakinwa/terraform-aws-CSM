resource "aws_security_group" "vprofile-bean-elb-sg" {
  name = "vprofile-bean-elb-sg"
  description = "Security group for bean-elb"
  vpc_id = "module.vpc.vpc_id"
  
  # Outbound traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Inbound traffic
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Bastion Host
resource "aws_security_group" "vprofile-bastion-sg" {
  name = "vprofile-bastion-sg"
  description = "Security group for bastion"
  vpc_id = "module.vpc.vpc_id"
  
    # Outbound traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Inbound traffic
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.MYIP]
  }
}


# EC2_ Beanstalk
resource "aws_security_group" "vprofile-prod-sg" {
  name = "vprofile-prod-sg"
  description = "Security group for beanstalk instance"
  vpc_id = "module.vpc.vpc_id"
  
    # Outbound traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Inbound traffic
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups =[aws_security_group.vprofile-bastion-sg.id]
  }
}

# Backend, RDS, active mq and Elastic cache
resource "aws_security_group" "vprofile-backend-sg" {
  name = "vprofile-backend-sg"
  description = "Security group for RDS, active mq and Elastic cache"
  vpc_id = "module.vpc.vpc_id"
  
    # Outbound traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Inbound traffic
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    security_groups =[aws_security_group.vprofile-prod-sg.id]
  }
}


# Allow interaction 
resource "aws_security_group_rule" "sec_group_allow_itself" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  security_group_id = aws_security_group.vprofile-backend-sg.id
  source_security_group_id = aws_security_group.vprofile-backend-sg.id
}
