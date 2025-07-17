# General
variable "ami" {
  description = "AMI ID for Amazon Linux 2"
  type        = string
}

# VPC & Subnet
variable "useast_vpc_cidr" {
  type = string
}

variable "useast_subnet_cidr" {
  type = string
}

variable "useast_az" {
  type = string
}

variable "uswest_vpc_cidr" {
  type = string
}

variable "uswest_subnet_cidr" {
  type = string
}

variable "uswest_az" {
  type = string
}

# Peering
variable "peer_region" {
  type = string
}
