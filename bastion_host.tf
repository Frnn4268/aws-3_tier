resource "aws_instance" "bastion_host" {
  depends_on    = [aws_subnet.public_subnets, aws_subnet.private_subnets, aws_lb.web_alb]
  ami           = var.web_server_ami
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.public_subnets["public-subnet-1"].id
  key_name      = var.key_pair
  user_data     = filebase64("${path.module}/${var.user_data_bastion_host}")
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  root_block_device {
    volume_size = 50  # Tamaño del disco en GB
    volume_type = "gp2"  # Tipo de volumen (gp2, io1, standard, etc.)
  }
  tags = {
    Name = "Bastion Host"
  }
}