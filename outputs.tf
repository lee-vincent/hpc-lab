output "vpc_id" {
  description = "ID of the HPC Lab VPC"
  value       = aws_vpc.hpc_lab.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "globus_connect_server_public_ip" {
  description = "Public IP address of the Globus Connect Server"
  value       = aws_eip.globus_connect_server.public_ip
}

output "globus_connect_server_private_ip" {
  description = "Private IP address of the Globus Connect Server"
  value       = aws_instance.globus_connect_server.private_ip
}

output "globus_connect_server_instance_id" {
  description = "Instance ID of the Globus Connect Server"
  value       = aws_instance.globus_connect_server.id
}

output "ubuntu_ami_id" {
  description = "Ubuntu 24.04 LTS AMI ID used"
  value       = data.aws_ami.ubuntu_24_04.id
}

output "ssh_connection_string" {
  description = "SSH connection command"
  value       = "ssh -i <your-key.pem> ubuntu@${aws_eip.globus_connect_server.public_ip}"
}