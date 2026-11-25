#Create marketing web
module "marketing" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [data.terraform_remote_state.vpc.outputs.subnet_ids["ru-central1-a"]]
  instance_name   = "web-marketing"
  instance_count  = 1
  image_family    = "ubuntu-2404-lts"
  public_ip       = true

  labels = { 
    project = "marketing"
     }

  metadata = {
    user-data           = data.template_file.cloudinit.rendered
    serial-port-enable  = 1
  }

}

#Create analytics web
module "analytics" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [data.terraform_remote_state.vpc.outputs.subnet_ids["ru-central1-a"]]
  instance_name   = "web-analytics"
  instance_count  = 1
  image_family    = "ubuntu-2404-lts"
  public_ip       = true

  labels = {
    project = "analytics"
     }

  metadata = {
    user-data           = data.template_file.cloudinit.rendered
    serial-port-enable  = 1
  }

}
