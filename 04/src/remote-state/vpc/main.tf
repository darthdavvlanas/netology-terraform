# Create vpc_prod
module "vpc_prod" {
  source = "./modules/vpc"
  env_name        = "prod"
  subnets_v4      = [
    {zone = "ru-central1-a", cidr = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]},
    {zone = "ru-central1-d", cidr = ["10.1.1.0/24", "10.1.2.0/24"]}
  ]
}
