# Test infrastructure for Emfirge CI/CD gate
# These resources intentionally have security issues matching demo findings

resource "aws_security_group" "ssh_open" # EMFIRGE FIX: SSH port 22 is open to the entire internet (0.0.0.0/0)
resource "aws_vpc_security_group_ingress_rule" "restrict_ssh" {
  security_group_id = "sg-0a1b2c3d4e5f00002"
  description       = "Restrict SSH to VPC CIDR only"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "10.0.0.0/8"
}

resource "aws_security_group" "rdp_open" {
  name        = "rdp-open-sg"
  description = "RDP open to the world (INTENTIONALLY INSECURE for testing)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "RDP from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rdp-open-sg"
    Env  = "demo"
  }
}

resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "HTTPS only (secure)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
    Env  = "demo"
  }
}

resource "aws_security_group" "legacy_app" {
  name        = "legacy-app-sg"
  description = "Internal port 8080 open to internet (INTENTIONALLY INSECURE)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internal app port open to internet"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "legacy-app-sg"
    Env  = "demo"
  }
}
