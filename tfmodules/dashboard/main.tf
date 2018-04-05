provider "aws" {
  region = "${var.region}"
}

data "template_file" "dashboard" {
  template = "{\"widgets\": [${join(",\n", var.widgets)}]}"
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.name}"
  dashboard_body = "${data.template_file.dashboard.rendered}"
}
