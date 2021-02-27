resource "aws_autoscaling_group" "asg" {
  name               = "webserver-asg"  
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2
  health_check_grace_period = 300
  vpc_zone_identifier       = ["${aws_subnet.private.id}"]
  health_check_type         = "EC2"
  launch_configuration      = "${(aws_launch_configuration.launchcg.name)}"

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]
}
