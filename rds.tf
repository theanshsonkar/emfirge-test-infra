# RDS instances — intentionally insecure for testing

resource "aws_db_instance" "prod_db" {
  identifier          = "prod-postgres"
  engine              = "postgres"
  engine_version      = "15.4"
  instance_class      = "db.t3.medium"
  allocated_storage   = 50
  db_name             = "emfirge"
  username            = "admin"
  password            = var.db_password

  # INTENTIONALLY INSECURE — public + unencrypted
  publicly_accessible = true
  storage_encrypted   = false
  multi_az            = false
  deletion_protection = false

  vpc_security_group_ids = [aws_security_group.web.id]
  db_subnet_group_name   = var.db_subnet_group

  tags = {
    Name = "prod-postgres"
    Env  = "demo"
  }
}

resource "aws_db_instance" "analytics_db" {
  identifier          = "analytics-mysql"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.small"
  allocated_storage   = 20
  db_name             = "analytics"
  username            = "analyst"
  password            = var.db_password

  # This one is secure
  publicly_accessible = false
  storage_encrypted   = true
  multi_az            = true
  deletion_protection = true

  vpc_security_group_ids = [aws_security_group.web.id]
  db_subnet_group_name   = var.db_subnet_group

  tags = {
    Name = "analytics-mysql"
    Env  = "demo"
  }
}
