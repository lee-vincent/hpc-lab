# Get latest Ubuntu 24.04 LTS AMI
data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Globus Connect Server EC2 Instance
# Instance type: t3.xlarge provides 4 vCPUs and 16 GB RAM
resource "aws_instance" "globus_connect_server" {
  ami                         = data.aws_ami.ubuntu_24_04.id
  instance_type               = "t3.xlarge" # 4 vCPUs, 16 GB RAM
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.globus_connect_server.id]
  associate_public_ip_address = true
  key_name                    = var.globus_key_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 100 # GB - suitable for HPC data staging
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name = "globus-connect-server-root"
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # IMDSv2 required for security
    http_put_response_hop_limit = 1
  }

  tags = {
    Name = "globus-connect-server"
    Role = "data-transfer"
  }

  lifecycle {
    ignore_changes = [ami] # Prevent recreation on AMI updates
  }
}

# Elastic IP for Globus Connect Server (recommended for stable endpoint)
resource "aws_eip" "globus_connect_server" {
  instance = aws_instance.globus_connect_server.id
  domain   = "vpc"

  tags = {
    Name = "globus-connect-server-eip"
  }

  depends_on = [aws_internet_gateway.hpc_lab]
}