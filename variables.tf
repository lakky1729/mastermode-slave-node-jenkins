# variables.tf

variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-west-2"
}

variable "vpc_id" {
  description = "VPC ID"
  default = "vpc-0bd8940b6c7175afe"
  # Add your VPC ID here
}

variable "master_ami" {
  description = "AMI ID for the Jenkins master node"
  default     = "ami-08e2c1a8d17c2fe17"
}

variable "master_instance_type" {
  description = "Instance type for the Jenkins master node"
  default     = "simple-jenkins"
}

variable "master_key_name" {
  description = "Key pair name for SSH access to the Jenkins master node"
  default     = "simple-jenkins"
}

variable "master_subnet_id" {
  description = "Subnet ID where the Jenkins master node will be launched"
  default     = "subnet-0899f564f48540ec4"
}

variable "master_private_key_path" {
  description = "Path to the private key file for SSH access to the Jenkins master node"
  default     = "C:/Users/LENOVO/Desktop/ec2pem/simple-jenkins.pem"
}

variable "worker_ami" {
  description = "AMI ID for the Jenkins worker nodes"
  default     = "ami-08e2c1a8d17c2fe17"
}

variable "worker_instance_type" {
  description = "Instance type for the Jenkins worker nodes"
  default     = "t2.micro"
}

variable "worker_key_name" {
  description = "Key pair name for SSH access to the Jenkins worker nodes"
  default     = "simple-jenkins"
}

variable "worker_subnet_ids" {
  description = "Subnet ID where the Jenkins worker nodes will be launched"
  type        = list(string)
  default     = [ "subnet-01613d94ce2a6c241", "subnet-0a10b660ea70c2d8e"]
}

variable "worker_private_key_path" {
  description = "Path to the private key file for SSH access to the Jenkins worker nodes"
  default     = "C:/Users/LENOVO/Desktop/ec2pem/simple-jenkins.pem"
}

variable "worker_environments" {
  description = "List of Jenkins worker environments"
  type        = list(string)
  default     = [ "prod", "qa"]
}
