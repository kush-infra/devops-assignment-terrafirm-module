locals {
  cluster_name = "${var.project_name}-cluster"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# VPC and Networking
module "vpc" {
  source = "./modules/vpc"

  name         = var.project_name
  vpc_cidr     = var.vpc_cidr
  cluster_name = local.cluster_name
  tags         = local.common_tags
}

# EKS Cluster
module "eks" {
  source = "./modules/eks"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = module.vpc.private_subnet_ids
  instance_type   = var.node_instance_type
  desired_nodes   = var.node_desired_count
  tags            = local.common_tags
}


