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
  cluster_name  = "webservers-dev"
  instance_type = "t3.micro"
  min_size      = 2
  max_size      = 4

  custom_tags = {
    Environment = "dev"
  }
  public_subnets = {
    a = "172.31.105.0/24"
    b = "172.31.106.0/24"
    c = "172.31.107.0/24"
  }
}
output "alb_dns_name" {
  value = module.webserver_cluster.alb_dns_name
}
