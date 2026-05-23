# EMFIRGE FIX: SSH port 22 is open to the entire internet (0.0.0.0/0)
resource "aws_vpc_security_group_ingress_rule" "restrict_ssh_access" {
  security_group_id = "sg-0a1b2c3d4e5f00002"
  description       = "Restrict SSH to VPC CIDR only"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "10.0.0.0/8"
}