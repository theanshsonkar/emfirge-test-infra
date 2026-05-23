variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = "vpc-demo123"
}

variable "public_subnet_id" {
  type        = string
  description = "Public subnet for web servers"
  default     = "subnet-pub123"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet for internal services"
  default     = "subnet-priv123"
}

variable "db_subnet_group" {
  type        = string
  description = "DB subnet group name"
  default     = "demo-db-subnets"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database password"
}
