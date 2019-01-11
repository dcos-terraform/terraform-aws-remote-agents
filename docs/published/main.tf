locals {
  region_local   = "us-east-1"
  region_spoke_1 = "us-west-2"
}

module "dcos" {
  source = "git@gitlocal.com:dcos-terraform/terraform-aws-dcos?ref=multi-region"
  # version = "~> 0.1.0"

  providers = {
    aws = "aws"
  }

  dcos_instance_os          = "coreos_1855.5.0"
  cluster_name              = "region1-cluster2"
  ssh_public_key_file       = "~/.ssh/id_rsa.pub"
  admin_ips                 = ["${data.http.whatismyip.body}/32"]
  num_masters               = "1"
  num_private_agents        = "2"
  num_public_agents         = "1"
  dcos_version              = "1.12.1"
  dcos_variant              = "ee"
  dcos_license_key_contents = "${file("./license.txt")}"

  dcos_install_mode = "${var.dcos_install_mode}"
}

module "spoke-1" {
  source = "dcos-terraform/remote-agents/aws"
  version = "~> 0.1.0"

  providers = {
    aws = "aws.spoke-1"
  }
  dcos_instance_os     = "coreos_1855.5.0"
  cluster_name         = "region2-cluster2"
  ssh_public_key_file  = "~/.ssh/id_rsa.pub"
  dcos_version         = "1.12.1"
  admin_ips            = ["${data.http.whatismyip.body}/32"]

  # enable_bootstrap     = true
  master_private_ips     = "${module.dcos.infrastructure-masters.private_ips}"

  enable_bootstrap     = false
  bootstrap_private_ip = "${module.dcos.infrastructure-bootstrap.private_ip}"

  # review with SRE 
  # bootstrap_prereq-id  = "${module.dcos.infrastructure-bootstrap.prereq-id}"
  # masters_prereq-id  = "${module.dcos.infrastructure-masters.prereq-id}"

  num_private_agents = "1"
  num_public_agents  = "1"
  subnet_range       = "172.13.0.0/16"

  dcos_variant              = "ee"
  dcos_license_key_contents = "${file("./license.txt")}"

  dcos_install_mode  = "${var.dcos_install_mode}"
}

module "vpc-peering" {
  source  = "dcos-terraform/vpc-peering/aws"
  version = "~> 2.0.0"

  providers = {
    aws.this = "aws"
    aws.peer = "aws.spoke-1"
  }

  peer_vpc_id              = "${module.spoke-1.infrastructure.vpc_id}"
  peer_cidr_block          = "${module.spoke-1.infrastructure.vpc_cidr_block}"
  peer_main_route_table_id = "${module.spoke-1.infrastructure.vpc_main_route_table_id}"
  peer_security_group_id   = "${module.spoke-1.infrastructure.security_group_internal_id}"
  this_cidr_block          = "${module.dcos.infrastructure.vpc_cidr_block}"
  this_main_route_table_id = "${module.dcos.infrastructure.vpc_main_route_table_id}"
  this_security_group_id   = "${module.dcos.infrastructure.security_group_internal_id}"
  this_vpc_id              = "${module.dcos.infrastructure.vpc_id}"
}

provider "aws" {
  region = "${local.region_local}"
}

# Local Region Output
output "masters-ips-site1" {
  value = "${module.dcos.masters-ips}"
}

output "cluster-address-site1" {
  value = "${module.dcos.masters-loadbalancer}"
}

output "public-agents-loadbalancer-site1" {
  value = "${module.dcos.public-agents-loadbalancer}"
}

provider "aws" {
  region = "${local.region_spoke_1}"
  alias  = "spoke-1"
}

variable "dcos_install_mode" {
  description = "specifies which type of command to execute. Options: install or upgrade"
  default     = "install"
}

data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

# Remote Region Output
output "private-agents-ips-site2" {
  value = "${module.spoke-1.private_agents-ips}"
}

output "public-agents-ips-site2" {
  value = "${module.spoke-1.public_agents-ips}"
}

output "public-agents-loadbalancer-site2" {
  value = "${module.spoke-1.public-agents-loadbalancer}"
}
