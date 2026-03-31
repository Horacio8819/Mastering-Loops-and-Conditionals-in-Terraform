variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "public_subnets" {
  description = "Map of public subnet CIDR blocks by AZ suffix"
  type        = map(string)

  default = {
    a = "10.0.1.0/24"
    b = "10.0.2.0/24"
    c = "10.0.3.0/24"
  }
}

variable "key_name" {
    default = "WebServerKeyPair"
}

variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type        = string
}

 variable "instance_type" {
   description = "EC2 instance type for the cluster"
   type        = string
 }

variable "min_size" {
  description = "Minimum number of EC2 instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of EC2 instances in the ASG"
  type        = number
}

variable "server_port" {
  description = "Port the server uses for HTTP"
  type        = number
  default     = 3025
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}


variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default = true
}

variable "environment" {
  type    = string
  description = "The environment to deploy to (e.g. dev, staging, production)"
}
