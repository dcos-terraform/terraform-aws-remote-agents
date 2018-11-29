output "private_agents-ips" {
  description = "Master IP addresses"
  value       = "${coalescelist(module.dcos-infrastructure.private_agents.public_ips, module.dcos-infrastructure.private_agents.private_ips)}"
}

output "public_agents-ips" {
  description = "Master IP addresses"
  value       = "${coalescelist(module.dcos-infrastructure.public_agents.public_ips, module.dcos-infrastructure.public_agents.private_ips)}"
}

output "public-agents-loadbalancer" {
  description = "This is the load balancer address to access the DC/OS public agents"
  value       = "${module.dcos-infrastructure.elb.public_agents_dns_name}"
}
