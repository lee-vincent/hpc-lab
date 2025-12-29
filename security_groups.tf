# Security Group for Globus Connect Server
resource "aws_security_group" "globus_connect_server" {
  name        = "globus-connect-server-sg"
  description = "Security group for Globus Connect Server"
  vpc_id      = aws_vpc.hpc_lab.id

  tags = {
    Name = "globus-connect-server-sg"
  }
}

# SSH Access from Admin IP
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "SSH access from admin IP"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.admin_ip

  tags = {
    Name = "ssh-admin-access"
  }
}

# HTTPS Inbound (Port 443)
resource "aws_vpc_security_group_ingress_rule" "https_inbound" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "HTTPS inbound from anywhere"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "https-inbound"
  }
}

# HTTPS Outbound (Port 443)
resource "aws_vpc_security_group_egress_rule" "https_outbound" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "HTTPS outbound to anywhere"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "https-outbound"
  }
}

# Globus Data Transfer Ports Inbound (50000-51000)
resource "aws_vpc_security_group_ingress_rule" "globus_data_inbound" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "Globus data transfer ports inbound"
  from_port         = 50000
  to_port           = 51000
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "globus-data-inbound"
  }
}

# Globus Data Transfer Ports Outbound (50000-51000)
resource "aws_vpc_security_group_egress_rule" "globus_data_outbound" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "Globus data transfer ports outbound"
  from_port         = 50000
  to_port           = 51000
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "globus-data-outbound"
  }
}

# General outbound for package updates (HTTP)
resource "aws_vpc_security_group_egress_rule" "http_outbound" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "HTTP outbound for package updates"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "http-outbound"
  }
}

# DNS outbound (required for name resolution)
resource "aws_vpc_security_group_egress_rule" "dns_udp_outbound" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "DNS UDP outbound"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "dns-udp-outbound"
  }
}

resource "aws_vpc_security_group_egress_rule" "dns_tcp_outbound" {
  security_group_id = aws_security_group.globus_connect_server.id
  description       = "DNS TCP outbound"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "dns-tcp-outbound"
  }
}