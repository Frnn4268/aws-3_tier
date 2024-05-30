# ALB target groups 
#----------------------------------------
# HTTP
resource "aws_lb_target_group" "web_alb_tg_http" {
  depends_on = [aws_lb.web_alb]
  name       = "${var.app_name}-${var.web_alb_tg_http["name"]}"
  port       = var.web_alb_tg_http["port"]
  protocol   = var.web_alb_tg_http["protocol"]
  vpc_id     = aws_vpc.vpc.id
}

# ALB listeners
#----------------------------------------
# HTTP
resource "aws_lb_listener" "web_alb_listener_http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = var.web_alb_listener_http["port"]
  protocol          = var.web_alb_listener_http["protocol"]

  default_action {
    type             = var.web_alb_listener_http["action_type"]
    target_group_arn = aws_lb_target_group.web_alb_tg_http.arn
  }
}