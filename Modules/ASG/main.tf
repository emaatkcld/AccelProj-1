resource "aws_ami_from_instance" "ACPJ1-ami" {
  name                    = "ACPJ1-docker-prod-ami"
  source_instance_id      = var.source-instance-id
  snapshot_without_reboot = true

  depends_on = [
    var.docker_prod
  ]

  tags = {
    "Name" = "ACPJ1-docker-prod-ami"
  }
}

## Launch Templates
resource "aws_launch_template" "ACPJ1-LT" {
  name          = var.name
  image_id      = aws_ami_from_instance.ACPJ1-ami.id
  instance_type = var.inst-type
  key_name      = var.key_name
  monitoring {
    enabled = false
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.docker-prod-sg-id]
    delete_on_termination = true
  }
  user_data = filebase64("${path.module}/asg.sh")
  
  tags = {
      Name = "ACPJ1-lt"
    }
}

#Create AutoScaling Group
resource "aws_autoscaling_group" "ACPJ1-asg" {
  name                      = "ACPJ1-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_template {
    id = aws_launch_template.ACPJ1-LT.id
    version = "$Latest"
    }
  vpc_zone_identifier       = [var.prvsn1, var.prvsn2]
  target_group_arns         = [var.prod-tg-arn]
  
  tag {
    key                 = var.tag_key_name
    value               = var.tag_value_name
    propagate_at_launch = true
  }

}

#Create ASG Policy
resource "aws_autoscaling_policy" "ACPJ1-asg-policy" {
  name = "ACPJ1-asg-policy"
  #scaling_adjustment     = 4
  policy_type     = "TargetTrackingScaling"
  adjustment_type = "ChangeInCapacity"
  #cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.ACPJ1-asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60.0
  }
}