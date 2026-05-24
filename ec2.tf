# EC2 instances — matching demo_seed.py for end-to-end testing
# demo_seed has i-0abc000000000003 with IMDSv1 + ssh-open-sg
# demo_seed has i-0abc000000000004 with IMDSv1 + legacy-app-sg

resource "aws_instance" "web_server" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t3.large"
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [aws_security_group.ssh_open.id]

  # INTENTIONALLY INSECURE — IMDSv1 (allows SSRF credential theft)
  # Matches demo_seed: i-0abc000000000003 imdsv2_required=False
  metadata_options {
    http_tokens = "optional"
  }

  tags = {
    Name = "i-0abc000000000003"
    Env  = "demo"
  }
}

resource "aws_instance" "legacy_app" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "m5.xlarge"
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [aws_security_group.web.id]

  # INTENTIONALLY INSECURE — IMDSv1
  # Matches demo_seed: i-0abc000000000004 imdsv2_required=False
  metadata_options {
    http_tokens = "optional"
  }

  tags = {
    Name = "i-0abc000000000004"
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
