module "vpc_useast" {
  source            = "./modules/networking"
  providers         = { aws = aws.useast }
  vpc_cidr          = var.useast_vpc_cidr
  subnet_cidr       = var.useast_subnet_cidr
  availability_zone = var.useast_az
}

module "vpc_uswest" {
  source            = "./modules/networking"
  providers         = { aws = aws.uswest }
  vpc_cidr          = var.uswest_vpc_cidr
  subnet_cidr       = var.uswest_subnet_cidr
  availability_zone = var.uswest_az
}

module "ec2_useast" {
  source        = "./modules/instance"
  providers     = { aws = aws.useast }
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = module.vpc_useast.subnet_id
  name          = "ec2-useast"
}

module "ec2_uswest" {
  source        = "./modules/instance"
  providers     = { aws = aws.uswest }
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = module.vpc_uswest.subnet_id
  name          = "ec2-uswest"
}

module "vpc_peering" {
  source = "./modules/peering"

  providers = {
    aws          = aws.useast
    aws.accepter = aws.uswest
  }

  requester_vpc_id         = module.vpc_useast.vpc_id
  accepter_vpc_id          = module.vpc_uswest.vpc_id
  requester_cidr           = var.useast_vpc_cidr
  accepter_cidr            = var.uswest_vpc_cidr
  requester_route_table_id = module.vpc_useast.route_table_id
  accepter_route_table_id  = module.vpc_uswest.route_table_id
  peer_region              = var.peer_region
}
