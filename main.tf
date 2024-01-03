# main.tf

provider "aws" {
  region = var.aws_region
}

# Jenkins Master Node
resource "aws_instance" "jenkins_master" {
  ami           = var.master_ami
  instance_type = var.master_instance_type
  key_name      = var.master_key_name
  subnet_id     = var.master_subnet_id

  vpc_security_group_ids = [aws_security_group.jenkins_master.id]

   tags = {
    Name        = "jenkins-master"
    Environment = "production"
    Owner       = "lakky"
    # Add additional tags as needed
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y default-jre",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins"
      
    ]
    

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.master_private_key_path)
      host        = self.public_ip
    }
  }

  # Output the master node's public IP for reference
 
}

# Jenkins Worker Nodes
# main.tf

resource "aws_instance" "jenkins_worker" {
  count         = length(var.worker_environments)
  ami           = var.worker_ami
  instance_type = var.worker_instance_type
  key_name      = var.worker_key_name
  # Remove the availability_zone attribute

  subnet_id     = var.worker_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.jenkins_master.id]

  tags = {
    Name        = "jenkins-worker-${var.worker_environments[count.index]}"
    Environment = var.worker_environments[count.index]
    Owner       = "lakky"
    # Add additional tags as needed
  }

  provisioner "remote-exec" {
    inline = [

        "sudo apt update",
      "sudo apt install -y default-jre",
      # Additional worker node setup commands if needed
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.worker_private_key_path)
      host        = self.public_ip
    }
  }

  # Output the worker nodes' public IPs for reference
  
}


# Security Group for Jenkins Master
resource "aws_security_group" "jenkins_master" {
  name        = "jenkins-master"
  description = "Security group for Jenkins master"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add other inbound rules if needed
  # ...

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Jenkins Workers
resource "aws_security_group" "jenkins_workers" {
  name        = "jenkins-workers"
  description = "Security group for Jenkins workers"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add other inbound rules if needed
  # ...

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
