provider "aws" {
  region = "${var.region}"
}

data "aws_instances" "ec2" {
  instance_tags {
    Name = "${var.tag_ec2}"
  }
}

data "template_file" "metrics" {
  count = "${length(data.aws_instances.ec2.ids)}"
  template = "${file("${path.module}/tpl_metrics.json")}"

  vars {
    type        = "${var.metric_type}" #AWS/EC2, AWS/ELB
    metric_name = "${var.metric_name}"
    instance_id = "${data.aws_instances.ec2.ids[count.index]}"
  }
}
data "template_file" "widget" {
  template = "${file("${path.module}/tpl_widget.json")}"

  vars {
    region  = "${var.region}"
    title   = "${var.title}"
    x       = "${var.position_x}"
    y       = "${var.position_y}"
    metrics = "${join(",\n", data.template_file.metrics.*.rendered)}"
  }
}
//resource "null_resource" "export_labels" {
//  provisioner "local-exec" {
//    command = "cat > rendered_labels.json <<EOL\n${join(",\n", data.template_file.label.*.rendered)}\nEOL"
//  }
//}