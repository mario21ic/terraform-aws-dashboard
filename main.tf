provider "aws" {
  region = "${var.region}"
}

module "aut_cpu" {
  source      = "./tfmodules/widget"
  region      = "${var.region}"

  tag_ec2     = "${var.tag_ec2}"
  metric_name = "CPUUtilization"
  metric_type = "AWS/EC2"
  title       = "aut_cpu"

  position_x  = "0"
  position_y  = "0"
}

module "network_in" {
  source      = "./tfmodules/widget"
  region      = "${var.region}"

  tag_ec2     = "${var.tag_ec2}"
  metric_name = "NetworkIn"
  metric_type = "AWS/EC2"
  title       = "aut_network_in"

  position_x  = "6"
  position_y  = "0"
}

module "network_out" {
  source      = "./tfmodules/widget"
  region      = "${var.region}"

  tag_ec2     = "${var.tag_ec2}"
  metric_name = "NetworkOut"
  metric_type = "AWS/EC2"
  title       = "aut_network_out"

  position_x  = "12"
  position_y  = "0"
}


module "dashboard" {
  source = "./tfmodules/dashboard"
  region = "${var.region}"

  name = "my-dashboard"
  widgets = [
    "${module.aut_cpu.rendered}",
    "${module.network_in.rendered}",
    "${module.network_out.rendered}"
  ]
}
