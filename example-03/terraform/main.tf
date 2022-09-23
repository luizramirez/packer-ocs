provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "xxxxxxx-terraform"
    key    = "node-ocs/$envionment/$environment.tfstate"
    region = "us-west-2"
  }
}

// Data used to grab latest AMI
data "aws_ami" "node_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = var.ami_name_value
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_iam_instance_profile" "node_profile" {
  name = var.profile_name
  role = aws_iam_role.node_role.name
}
resource "aws_iam_role" "node_role" {
  name = var.iam_role
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


resource "aws_launch_configuration" "node_lc" {
  image_id             = data.aws_ami.node_ami.id
  name_prefix          = var.lc_name
  instance_type        = var.instance_type
  security_groups      = var.security_groups
  key_name             = var.key_name
  iam_instance_profile = aws_iam_instance_profile.node_profile.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "node_asg" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.node_lc.name
  min_size             = 1
  max_size             = 1
  vpc_zone_identifier  = var.vpc_zone_identifier
  default_cooldown     = 0

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 90
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = var.ec2_name
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
  tag {
    key                 = "AMI"
    value               = data.aws_ami.node_ami.id
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
