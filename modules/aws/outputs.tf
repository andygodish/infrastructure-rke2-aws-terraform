data "template_file" "init_server_userdata" {
  template = file("${path.module}/templates/init_server_userdata.sh")

  vars = {
    cp_lb_host = aws_elb.rke2_cp_elb.dns_name
    rke2_token = random_string.rke2_token.result
  }
}

data "template_file" "server_userdata" {
  template = file("${path.module}/templates/server_userdata.sh")

  vars = {
    cp_lb_host = aws_elb.rke2_cp_elb.dns_name
    rke2_token = random_string.rke2_token.result
    server_ip  = aws_instance.init_server[0].public_ip
  }
}

data "template_file" "agent_userdata" {
  template = file("${path.module}/templates/agent_userdata.sh")

  vars = {
    cp_lb_host = aws_elb.rke2_cp_elb.dns_name
    rke2_token = random_string.rke2_token.result
  }
}

resource "local_file" "ssh_config" {
  content = templatefile("${path.module}/templates/ssh_config.tpl",
    {
      init_server_ip = aws_instance.init_server[0].public_ip
      server_ip_0    = aws_instance.server[0].public_ip
      server_ip_1    = aws_instance.server[1].public_ip
      user           = var.amis[var.region][var.os].user
    }
  )
  filename = "ssh_config"
}
resource "local_file" "hosts_ini" {
  content = templatefile("${path.module}/templates/hosts.tpl", {}
  )
  filename = "hosts.ini"
}

resource "local_file" "instance_profile" {
  content = templatefile("${path.module}/templates/instance_profile.tpl",
    {
      server_iam_profile = aws_iam_instance_profile.rke2_master_iam_profile.name
      agent_iam_profile  = aws_iam_instance_profile.rke2_agent_iam_profile.name
    }
  )
  filename = "instance_profile.yml"
}

resource "local_file" "all_yml" {
  content = templatefile("${path.module}/templates/all.tpl",
    {
      user = var.amis[var.region][var.os].user
    }
  )
  filename = "all.yml"
}