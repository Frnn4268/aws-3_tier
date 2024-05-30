# ALB
#----------------------------------------
resource "aws_lb" "web_alb" {
  depends_on         = [aws_subnet.public_subnets, aws_subnet.private_subnets]
  name               = "${var.app_name}-${var.load_balancer_name}"
  internal           = var.load_balancer_external
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.web_access_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]

  tags = {
    Name = "${var.app_name}-${var.load_balancer_name}"
  }
}
