# output.tf

output "master_public_ip" {
  description = "Public IP address of the Jenkins master node"
  value       = aws_instance.jenkins_master.public_ip
}

output "worker_public_ips" {
  description = "List of public IP addresses of Jenkins worker nodes"
  value       = aws_instance.jenkins_worker[*].public_ip
}

output "jenkins_url" {
  description = "URL to access Jenkins on the master node"
  value       = "http://${aws_instance.jenkins_master.public_ip}:8080"
}
