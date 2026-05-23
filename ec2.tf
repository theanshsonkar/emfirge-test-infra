# EC2 instances — one with IMDSv1 (insecure), one with IMDSv2 (secure)

resource "aws_instance" "web_server" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t3.medium"
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [aws_security_group.ssh_open.id]

  # INTENTIONALLY INSECURE — IMDSv1 (allows SSRF credential theft)
  metadata_options {
    http_tokens = "optional"
  }

  tags = {
    Name = "web-server-prod"
    Env  = "demo"
  }
}

resource "aws_instance" "api_server" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t3.small"
  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [aws_security_group.web.id]

  # Secure — IMDSv2 enforced
  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name = "api-server"
    Env  = "demo"
  }
}
