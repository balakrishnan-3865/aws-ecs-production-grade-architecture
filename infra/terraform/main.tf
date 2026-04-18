module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                = var.vpc_cidr
  public_subnet_1_cidr    = var.public_subnet_1_cidr
  public_subnet_2_cidr    = var.public_subnet_2_cidr
  private_subnet_1_cidr   = var.private_subnet_1_cidr
  private_subnet_2_cidr   = var.private_subnet_2_cidr
  region                  = var.region
}

module "alb" {
  source = "./modules/alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "ecs" {
  source = "./modules/ecs"

  cluster_name   = "springboot-cluster"
  service_name   = "springboot-service"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  target_group_arn = module.alb.target_group_arn
}