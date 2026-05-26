# RDS instances — matching demo_seed.py resource IDs for end-to-end testing

resource "aws_db_instance" "prod_db" {
  identifier          = "acme-prod-db"
  engine              = "postgres"
  engine_version      = "15.4"
  instance_class      = "db.t3.medium"
  allocated_storage   = 50
  db_name             = "emfirge"
  username            = "admin"
  password            = var.db_password

  # Secure — private + encrypted (matches demo_seed: publicly_accessible=False, encrypted=True)
  publicly_accessible = false
  storage_encrypted   = true
  multi_az            = false
  deletion_protection = true

  vpc_security_group_ids = [aws_security_group.web.id]
  db_subnet_group_name   = var.db_subnet_group

  tags = {
    Name = "acme-prod-db"
    Env  = "demo"
  }
}

resource "aws_db_instance" "analytics_db" # Fix: RDS instances without deletion protection enabled: acme-analytics-db
# Resource: acme-analytics-db
+ # Emfirge-generated remediation
