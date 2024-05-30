# environment vars
#---------------------------------------
variable "environment" {
  type    = string
  default = "Dev"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
# naming vars
#---------------------------------------
variable "app_name" {
  type        = string
  description = "app name prefix for naming"
  default     = "shoppr"
}

# vpc vars
#----------------------------------------
variable "vpc_cidr" {
  type        = string
  description = "VPC cidr block"
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "enable dns hostnames"
  default     = true
}

# common cidrs
#----------------------------------------
variable "all_traffic" {
  type        = string
  description = "all all traffic"
  default     = "0.0.0.0/0"
}

variable "NAT_subnet" {
  type        = string
  description = "subnet location for NAT"
  default     = "us"
}

# private subnet vars
#----------------------------------------
variable "private_subnets" {
  default = {
    "private-subnet-1" = 0
    "private-subnet-2" = 1
  }
}

# public subnet vars
#----------------------------------------
variable "public_subnets" {
  default = {
    "public-subnet-1" = 0
    "public-subnet-2" = 1
  }
}
variable "auto_ipv4" {
  type        = bool
  description = "enable auto-assign ipv4"
  default     = true
}

# security group vars
#----------------------------------------
variable "ssh_sg" {
  type        = map(any)
  description = "ssh security group vars "
  default = {
    "cidr_block"            = "0.0.0.0/0"
    "create_before_destroy" = true
    "timeout_delete"        = "2m"
  }
}

variable "web_access_sg" {
  type        = map(any)
  description = "web access security group vars "
  default = {
    "create_before_destroy" = true
    "timeout_delete"        = "2m"
  }
}

variable "alb_access_sg" {
  type        = map(any)
  description = "alb instance security group vars "
  default = {
    "create_before_destroy" = true
    "timeout_delete"        = "2m"
  }
}


# ec2 vars
#----------------------------------------
variable "web_server_name" {
  type    = string
  default = "web-server"
}
variable "web_server_ami" {
  type        = string
  description = "Instance AMI: Ubuntu 22.04"
  default     = "ami-04b70fa74e45c3917"
}
variable "web_server_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair" {
  type        = string
  description = "ec2 key pair"
  default     = "webServer_key"
}

variable "user_data_file" {
  type        = string
  description = "user data file path"
  default     = "pre-deployment.sh"
}

variable "user_data_bastion_host" {
  type        = string
  description = "user data file path"
  default     = "hosted-runner.sh"
}

# ASG vars
#----------------------------------------
variable "web_asg_capacity" {
  type        = map(any)
  description = "min, max, and desired instance capacity"
  default = {
    "min" = 2
    "max" = 2
  }
}
variable "web_asg_health_check_type" {
  type        = string
  description = "health check type"
  default     = "ELB"
}
variable "health_check_grace_period" {
  type = number
  description = "Time (in seconds) after instance comes into service before checking health."
  default = 600
}

variable "web_asg_scaling_policy" {
  type        = map(any)
  description = "scaling policy"
  default = {
    "policy_type"  = "TargetTrackingScaling"
    "metric_type"  = "ASGAverageCPUUtilization"
    "target_value" = 75.0
  }
}

# ALB vars
#----------------------------------------
variable "load_balancer_name" {
  type        = string
  description = "load balancer name"
  default     = "web-alb"
}

variable "load_balancer_backend_name" {
  type        = string
  description = "load balancer name"
  default     = "app-alb"
}

variable "load_balancer_external" {
  type        = bool
  description = "Is looad balancer internal facing?"
  default     = false
}

variable "load_balancer_internal" {
  type        = bool
  description = "Is looad balancer internal facing?"
  default     = true
}

variable "load_balancer_type" {
  type        = string
  description = "load balancer"
  default     = "application"
}

# ALB target group vars
#----------------------------------------
variable "web_alb_tg_http" {
  type        = map(any)
  description = "http target group vars"
  default = {
    "name"     = "web-server-tg-http"
    "port"     = 80
    "protocol" = "HTTP"

  }
}

variable "web_alb_tg_https" {
  type        = map(any)
  description = "https target group vars"
  default = {
    "name"     = "web-server-tg-https"
    "port"     = 443
    "protocol" = "HTTPS"

  }
}

variable "app_nlb_tg_node" {
  type        = map(any)
  description = "http target group vars"
  default = {
    "name"     = "app-tg-node"
    "port"     = 4000
    "protocol" = "TCP"

  }
}

# ALB listener vars
#----------------------------------------
variable "web_alb_listener_http" {
  type        = map(any)
  description = "http listener vars"
  default = {
    "port"        = 80
    "protocol"    = "HTTP"
    "action_type" = "forward"
  }
}

variable "web_alb_listener_https" {
  type        = map(any)
  description = "https listener vars"
  default = {
    "port"        = 443
    "protocol"    = "HTTPS"
    "action_type" = "forward"
  }
}

variable "app_nlb_listener_node" {
  type        = map(any)
  description = "https listener vars"
  default = {
    "port"        = 4000
    "protocol"    = "TCP"
    "action_type" = "forward"
  }
}
