# Multiple Providers for Multi-Cluster Example

Below contains an example of how a user calls multiple providers to create multiple DC/OS clusters across different regions. This example will be used to create multiple regions on a single cluster. This README was captures to showcase a working example.


```hcl
variable "dcos_install_mode" {
  description = "specifies which type of command to execute. Options: install or upgrade"
  default     = "install"
}

data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-west-2"
  alias = "remote"
}

module "dcos1" {
  source  = "dcos-terraform/dcos/aws"
  version = "~> 0.1"

  providers = {
    aws = "aws"
  }

  dcos_instance_os    = "coreos_1855.5.0"
  cluster_name        = "region1"
  ssh_public_key_file = "~/.ssh/id_rsa.pub"
  admin_ips           = ["${data.http.whatismyip.body}/32"]

  num_masters        = "1"
  num_private_agents = "2"
  num_public_agents  = "1"

  dcos_version = "1.11.4"

  # dcos_variant              = "ee"
  # dcos_license_key_contents = "${file("./license.txt")}"
  dcos_variant = "open"

  dcos_install_mode = "${var.dcos_install_mode}"
}

module "dcos2" {
  source  = "dcos-terraform/dcos/aws"
  version = "~> 0.1"

  providers = {
    aws   = "aws.remote"
  }

  dcos_instance_os    = "coreos_1855.5.0"
  cluster_name        = "region2"
  ssh_public_key_file = "~/.ssh/id_rsa.pub"
  admin_ips           = ["${data.http.whatismyip.body}/32"]

  num_masters        = "1"
  num_private_agents = "2"
  num_public_agents  = "1"

  dcos_version = "1.11.4"

  # dcos_variant              = "ee"
  # dcos_license_key_contents = "${file("./license.txt")}"
  dcos_variant = "open"

  dcos_install_mode = "${var.dcos_install_mode}"
}

output "masters-ips-site1" {
  value = "${module.dcos1.masters-ips}"
}

output "cluster-address-site1" {
  value = "${module.dcos1.masters-loadbalancer}"
}

output "public-agents-loadbalancer-site1" {
  value = "${module.dcos1.public-agents-loadbalancer}"
}

output "masters-ips-site2" {
  value = "${module.dcos2.masters-ips}"
}

output "cluster-address-site2" {
  value = "${module.dcos2.masters-loadbalancer}"
}

output "public-agents-loadbalancer-site2" {
  value = "${module.dcos2.public-agents-loadbalancer}"
}
```
