# EMFIRGE FIX: SSH port 22 is open to the entire internet (0.0.0.0/0)
resource "aws_security_group" "sg_066a7e4eecc6f5e86" {
  provider = aws.ap-south-1
}

resource "aws_vpc_security_group_ingress_rule" "revoke_ssh_0_0_0_0" {
  security_group_id = "sg-066a7e4eecc6f5e86"

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "Revoke SSH from internet"
  }

  lifecycle {
    ignore_changes = all
  }
}