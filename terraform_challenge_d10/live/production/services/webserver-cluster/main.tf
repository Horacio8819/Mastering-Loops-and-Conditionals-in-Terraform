provider "aws" {
  region = "eu-central-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
module "webserver_cluster" {
  source =  "../../../../modules/services/webserver-cluster"
  cluster_name  = "webservers-production"
  instance_type = "t3.small"
  environment = "production"
  min_size      = 4
  max_size      = 10

  custom_tags = {
    Environment = "production"
  }
  public_subnets = {
    a = "172.31.108.0/24"
    b = "172.31.109.0/24"
    c = "172.31.110.0/24"
  }
}
output "alb_dns_name" {
  value = module.webserver_cluster.alb_dns_name
}
