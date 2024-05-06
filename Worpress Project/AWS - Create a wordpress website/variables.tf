variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type for WordPress server"
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EC2 instance"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
  default     = []
}

variable "database_username" {
  description = "Username for the WordPress database"
  default     = "wordpress"
}

variable "database_password" {
  description = "Password for the WordPress database"
}

variable "database_name" {
  description = "Name of the WordPress database"
  default     = "wordpress"
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the EC2 instance"
}

variable "wordpress_admin_username" {
  description = "WordPress admin username"
  default     = "admin"
}

variable "wordpress_admin_password" {
  description = "WordPress admin password"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}