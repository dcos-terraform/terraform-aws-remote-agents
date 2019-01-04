variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "dcos-example"
}

variable "aws_key_name" {
  description = "Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key to none"
  default     = ""
}

variable "ssh_public_key" {
  description = "SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent."

  default = ""
}

variable "ssh_public_key_file" {
  description = "Path to SSH public key. This is mandatory but can be set to an empty string if you want to use ssh_public_key with the key as string."
}

variable "num_bootstrap" {
  description = "Specify the amount of bootstrap. You should have at most 1"
  default     = 0
}

variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
  default     = 0
}

variable "num_private_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
  default     = 2
}

variable "num_public_agents" {
  description = "Specify the amount of public agents. These agents will host marathon-lb and edgelb"
  default     = 1
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "admin_ips" {
  type        = "list"
  description = "List of CIDR admin IPs"
}

variable "availability_zones" {
  type        = "list"
  description = "Availability zones to be used"
  default     = []
}

variable "aws_ami" {
  description = "AMI that will be used for the instances instead of Mesosphere provided AMIs"
  default     = ""
}

variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "centos_7.5"
}

variable "bootstrap_aws_ami" {
  description = "[BOOTSTRAP] AMI to be used"
  default     = ""
}

variable "bootstrap_os" {
  description = "[BOOTSTRAP] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "bootstrap_root_volume_size" {
  description = "[BOOTSTRAP] Root volume size in GB"
  default     = "80"
}

variable "bootstrap_root_volume_type" {
  description = "[BOOTSTRAP] Root volume type"
  default     = "standard"
}

variable "bootstrap_instance_type" {
  description = "[BOOTSTRAP] Instance type"
  default     = "t2.medium"
}

variable "bootstrap_associate_public_ip_address" {
  description = "[BOOTSTRAP] Associate a public ip address with there instances"
  default     = true
}

variable "private_agents_aws_ami" {
  description = "[PRIVATE AGENTS] AMI to be used"
  default     = ""
}

variable "private_agents_os" {
  description = "[PRIVATE AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "private_agents_root_volume_size" {
  description = "[PRIVATE AGENTS] Root volume size in GB"
  default     = "120"
}

variable "private_agents_root_volume_type" {
  description = "[PRIVATE AGENTS] Root volume type"
  default     = "gp2"
}

variable "private_agents_instance_type" {
  description = "[PRIVATE AGENTS] Instance type"
  default     = "m4.xlarge"
}

variable "private_agents_associate_public_ip_address" {
  description = "[PRIVATE AGENTS] Associate a public ip address with there instances"
  default     = true
}

variable "public_agents_aws_ami" {
  description = "[PUBLIC AGENTS] AMI to be used"
  default     = ""
}

variable "public_agents_os" {
  description = "[PUBLIC AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "public_agents_root_volume_size" {
  description = "[PUBLIC AGENTS] Root volume size"
  default     = "120"
}

variable "public_agents_root_volume_type" {
  description = "[PUBLIC AGENTS] Specify the root volume type."
  default     = "gp2"
}

variable "public_agents_instance_type" {
  description = "[PUBLIC AGENTS] Instance type"
  default     = "m4.xlarge"
}

variable "public_agents_associate_public_ip_address" {
  description = "[PUBLIC AGENTS] Associate a public ip address with there instances"
  default     = true
}

variable "public_agents_additional_ports" {
  description = "List of additional ports allowed for public access on public agents (80 and 443 open by default)"
  default     = []
}

variable "cluster_name_random_string" {
  description = "Add a random string to the cluster name"
  default     = false
}

variable "bootstrap_ip" {
  description = "The bootstrap IP to SSH to"
  default     = ""
}

variable "bootstrap_os_user" {
  default     = ""
  description = "The OS user to be used with ssh exec (only for bootstrap)"
}

variable "bootstrap_prereq-id" {
  description = "Workaround making the bootstrap install depending on an external resource (e.g. nullresource.id)"
  default     = ""
}

variable "master_ips" {
  type        = "list"
  description = "List of masterips to SSH to"
  default     = []
}

variable "master_private_ips" {
  type        = "list"
  description = "list of master private ips"
  default     = []
}

variable "masters_os_user" {
  default     = ""
  description = "The OS user to be used with ssh exec ( only for masters )"
}

variable "masters_prereq-id" {
  description = "Workaround making the masters install depending on an external resource (e.g. nullresource.id)"
  default     = ""
}

variable "private_agent_ips" {
  type        = "list"
  description = "List of private agent IPs to SSH to"
  default     = []
}

variable "private_agents_os_user" {
  default     = ""
  description = "The OS user to be used with ssh exec ( only for private agents )"
}

variable "private_agents_prereq-id" {
  description = "Workaround making the private agent install depending on an external resource (e.g. nullresource.id)"
  default     = ""
}

variable "public_agent_ips" {
  type        = "list"
  description = "List of public agent IPs to SSH to"
  default     = []
}

variable "public_agents_os_user" {
  default     = ""
  description = "The OS user to be used with ssh exec (only for public agents)"
}

variable "public_agents_prereq-id" {
  description = "Workaround making the public agent install depending on an external resource (e.g. nullresource.id)"
  default     = ""
}

variable "subnet_range" {
  description = "Private IP space to be used in CIDR format"
  default     = "172.14.0.0/16"
}

variable "enable_bootstrap" {
  description = "Sets whether to deploy bootstrap commands on provided ip address"
  default     = "false"
}
