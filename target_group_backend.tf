# NLB target groups 
#----------------------------------------
# HTTP
resource "aws_lb_target_group" "app_nlb_tg_http" {
  depends_on = [aws_lb.app_nlb]
  name       = "${var.app_name}-${var.app_nlb_tg_node["name"]}"
  port       = var.app_nlb_tg_node["port"]
  protocol   = var.app_nlb_tg_node["protocol"]
  vpc_id     = aws_vpc.vpc.id
}

# NLB listeners
#----------------------------------------
# HTTP
resource "aws_lb_listener" "app_nlb_listener_http" {
  load_balancer_arn = aws_lb.app_nlb.arn
  port              = var.app_nlb_listener_node["port"]
  protocol          = var.app_nlb_listener_node["protocol"]

  default_action {
    type             = var.app_nlb_listener_node["action_type"]
    target_group_arn = aws_lb_target_group.app_nlb_tg_http.arn
  }
}