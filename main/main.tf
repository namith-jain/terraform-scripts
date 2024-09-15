# configure aws provider
provider "aws" {
  region  = var.region
  access_key = ""
  secret_key = ""
}

# create vpc
module "vpc" {
  source                  = "../modules/vpc-subnets"
  region                  = var.region
  environment             = var.environment
  project                  = var.project
  create_type             = var.create_type
  vpc_cidr                = var.vpc_cidr
  public_subnet_az1_cidr  = var.public_subnet_az1_cidr
  public_subnet_az2_cidr  = var.public_subnet_az2_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
}

# create Nat Gateway
module "nat-gateway" {
  source                = "../modules/nat-gateway"
  environment           = var.environment
  project                = var.project
  create_type           = var.create_type
  vpc_id                = module.vpc.vpc_id
  internet_gateway      = module.vpc.internet_gateway
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  private_subnet_az1_id = module.vpc.private_subnet_az1_id
  private_subnet_az2_id = module.vpc.private_subnet_az2_id
}

