
data "template_file" "user_data" {
  template = file("${path.module}/${var.user_data_file}")

  vars = {
    backend_url = "http://${aws_lb.app_nlb.dns_name}"
  }
}

# EC2 web launch template
#----------------------------------------
resource "aws_launch_template" "web_server" {
  name                   = "${var.app_name}-${var.web_server_name}-template"
  image_id               = var.web_server_ami
  instance_type          = var.web_server_type
  user_data              = base64encode(data.template_file.user_data.rendered)
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.alb_access_sg.id, aws_security_group.nlb_backend_access_sg.id]
  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 50
    }
  }
  tags = {
    "Name" = "${var.app_name}-${var.web_server_name}-template"
  }
}