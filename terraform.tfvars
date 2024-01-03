# terraform.tfvars

aws_region                 = "us-west-2"
vpc_id                     = "vpc-0bd8940b6c7175afe"
master_ami                 = "ami-08e2c1a8d17c2fe17"
master_instance_type       = "t2.micro"
master_key_name            = "simple-jenkins"
master_subnet_id           = "subnet-0899f564f48540ec4"
master_private_key_path    = "C:/Users/LENOVO/Desktop/ec2pem/simple-jenkins.pem"
worker_ami                 = "ami-08e2c1a8d17c2fe17"
worker_instance_type       = "t2.micro"
worker_key_name            = "simple-jenkins"
worker_subnet_ids           = [ "subnet-01613d94ce2a6c241", "subnet-0a10b660ea70c2d8e"]
worker_private_key_path    = "C:/Users/LENOVO/Desktop/ec2pem/simple-jenkins.pem"
