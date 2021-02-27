resource "aws_launch_configuration" "launchcg" {
  name = "launch-config"
  image_id        = "${(var.webservers_ami)}"
  instance_type   = "${var.instance_type}"
#  security_groups = "$[(aws_security_group.webservers.name)]"
#  security_groups = "${data.aws_security_group.webservers.name}"
  security_groups = [aws_security_group.webservers.id]
  user_data                 = "${file("install_httpd.sh")}"
  ebs_block_device  {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
      encrypted             = false
      iops                  = 100
      snapshot_id           = ""
      no_device             = false
    }
  
  root_block_device  {
      volume_size = "50"
      volume_type = "gp2"
      encrypted             = false
      delete_on_termination = true
      iops                  = 100
    }
}
