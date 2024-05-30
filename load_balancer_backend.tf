# NLB
#----------------------------------------
resource "aws_lb" "app_nlb" {
  depends_on         = [aws_subnet.public_subnets, aws_subnet.private_subnets]
  name               = "${var.app_name}-${var.load_balancer_backend_name}"
  internal           = var.load_balancer_external
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb_backend_access_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]

  tags = {
    Name = "${var.app_name}-${var.load_balancer_backend_name}"
  }
}