resource "local_file" "hosts_templatefile" {
  content       = templatefile("${path.module}/hosts.tftpl", {
    webservers  = yandex_compute_instance.web
    databases   = yandex_compute_instance.database
    storage     = [yandex_compute_instance.storage]
  })

  filename      = "${abspath(path.module)}/hosts.ini"
}

resource null_resource "ansible" {
  depends_on    = [
    yandex_compute_instance.web,
    yandex_compute_instance.storage,
    local_file.hosts_templatefile]
  triggers      = {
    inventory_hash = local_file.hosts_templatefile.content_md5
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "guskov-ka"
      private_key = file("~/.ssh/k.guskov")
      host        = yandex_compute_instance.web[0].network_interface[0].nat_ip_address
    }

    inline = ["echo 'SSH is ready'"]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${abspath(path.module)}/ansible.cfg ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/test.yml"
  }
}
