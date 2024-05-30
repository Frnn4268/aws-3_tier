
# ssh security group
#----------------------------------------------------
resource "aws_security_group" "ssh_sg" {
  name        = "${var.app_name}-ssh-sg"
  description = "Allow ssh"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "ssh from IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_sg["cidr_block"]]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.ssh_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.app_name}-ssh-sg"
  }
}

# Bastion Host Access
resource "aws_security_group" "bastion_sg" {
  name        = "${var.app_name}-bastion-sg"
  description = "Allow all for bastian host"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "ssh from IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_traffic]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.ssh_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.app_name}-bastion-sg"
  }
}

# Web access security group
#----------------------------------------------------
resource "aws_security_group" "web_access_sg" {
  name        = "${var.app_name}-web-access-sg"
  description = "web access sg applied to alb"
  vpc_id      = aws_vpc.vpc.id

  # http
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }
  # https
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  # backend
  ingress {
    description = "BACKEND"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_traffic]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.web_access_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.app_name}-web-access-sg"
  }
}

# ALB access security group
#----------------------------------------------------
resource "aws_security_group" "alb_access_sg" {
  name        = "${var.app_name}-alb-access-sg"
  description = "Allow http traffic from ALB"
  vpc_id      = aws_vpc.vpc.id

  # http
  ingress {
    description     = "allow http traffic from alb sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_access_sg.id]
  }
  # https
  ingress {
    description     = "allow https traffic from alb sg"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.web_access_sg.id]
  }

  # node js
  ingress {
    description     = "allow https traffic from alb sg"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.web_access_sg.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_traffic]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.alb_access_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.app_name}-alb-access-sg"
  }
}

resource "aws_security_group" "nlb_backend_access_sg" {
  name        = "${var.app_name}-nlb-backend-access-sg"
  description = "Allow http traffic from NLB"
  vpc_id      = aws_vpc.vpc.id

  # http
  ingress {
    description     = "allow http traffic from alb sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_access_sg.id]
  }
  # https
  ingress {
    description     = "allow https traffic from alb sg"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.web_access_sg.id]
  }

  # node js
  ingress {
    description     = "allow https traffic from alb sg"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.web_access_sg.id]
  }

  # All
  ingress {
    description     = "allow https traffic from alb sg"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_traffic]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_traffic]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.alb_access_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.app_name}-nlb-backend-access-sg"
  }
}
