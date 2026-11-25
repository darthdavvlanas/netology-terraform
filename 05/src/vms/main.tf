# Create vpc
module "vpc" {
  source = "./modules/vpc"
  env_name        = "develop"
  subnets_v4      = [
    {zone = "ru-central1-a", cidr = ["10.0.1.0/24"]}
  ]
}

# Create vpc_prod
module "vpc_prod" {
  source = "./modules/vpc"
  env_name        = "prod"
  subnets_v4      = [
    {zone = "ru-central1-a", cidr = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]},
    {zone = "ru-central1-d", cidr = ["10.1.1.0/24", "10.1.2.0/24"]}
  ]
}

#Create marketing web
module "marketing" {
  depends_on      = [module.vpc_prod]
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_prod.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [module.vpc_prod.subnet_id["ru-central1-a"]]
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
  depends_on      = [module.vpc_prod]
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_prod.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [module.vpc_prod.subnet_id["ru-central1-a"]]
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

#Create MySQL cluster
module "mdb-cluster" {
  depends_on        = [module.vpc_prod]
  source            = "./modules/mdb-cluster"
  cluster_name      = "example"
  network_id        = module.vpc_prod.network_id
  subnet_ids        = module.vpc_prod.subnet_id
  subnet_zones      = module.vpc_prod.subnet_zones
  assign_public_ip  = false
  HA                = true
  # host_count        = 3 # <--- if you need more than 2 hosts
}

#Create DB and users
module "db-user" {
  depends_on      = [module.mdb-cluster]
  source          = "./modules/mdb-user"
  cluster_id      = module.mdb-cluster.cluster_id
  db_name         = "test"
  db_users        = [
    {name = "app", roles = ["ALL"]}
  ]
}

data "template_file" "cloudinit" {
  template  = file("./cloud-init.yml")
  
  vars = {
    user     = var.user
    ssh_keys = file("~/.ssh/k.guskov.pub")
  }
}