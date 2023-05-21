output "Private_Instances_IP_addresses" {
  description = "List of private IP addresses."
  value       = aws_instance.private[*].private_ip
}

output "Bastion_Host_IP_address" {
  description = "Public IP of the bastion host."
  value       = aws_instance.bastion.public_ip
}

output "Load_balancer_HTTP_DNS" {
  description = "Public DNS name to reach the created HTTP publication."
  value       = aws_lb.alb.dns_name
}

output "SSH_key_Content" {
  description = "The SSH key to connect to all instances."
  value       = var.SSH_key_Content
}

output "Usernames" {
  description = "The usernames to connect to the instances."
  value       = "ubuntu" 
}
