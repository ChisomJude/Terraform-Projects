// Create an RDS database for WordPress
resource "aws_db_instance" "wordpress_db" {
  identifier             = "wordpressdb"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = var.database_username
  password               = var.database_password
  #name                   = var.database_name
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false

  tags = {
    Name = "wordpressdb"
  }
}

// Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "wordpress-vpc"
  }
}

// Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "wordpress-igw"
  }
}

// Create public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "wordpress-public-subnet"
  }
}

// Create private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks[1]

  tags = {
    Name = "wordpress-private-subnet"
  }
}

// Create route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "wordpress-public-route-table"
  }
}

// Create route for internet gateway
resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

// Associate public subnet with public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

// Create security group for WordPress
resource "aws_security_group" "wordpress_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-security-group"
  }
}

// Launch an EC2 instance for WordPress
resource "aws_instance" "wordpress_instance" {
  ami                    = "ami-0d66e65484105adff" // Replace with your AMI ID, Here is AMI for Ubuntu 22.04
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids     = aws_security_group.wordpress_sg.id
  key_name               = var.key_name 
  associate_public_ip_address = true

  // Provisioning script for WordPress setup
  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y apache2 mariadb-server php php-mysql php-gd php-curl php-mbstring
              systemctl start apache2
              systemctl enable apache2
              systemctl start mariadb
              systemctl enable mariadb
              mysql -e "CREATE DATABASE ${var.database_name};"
              mysql -e "CREATE USER '${var.database_username}'@'localhost' IDENTIFIED BY '${var.database_password}';"
              mysql -e "GRANT ALL PRIVILEGES ON ${var.database_name}.* TO '${var.database_username}'@'localhost';"
              mysql -e "FLUSH PRIVILEGES;"
              curl -O https://wordpress.org/latest.tar.gz
              tar xzvf latest.tar.gz
              rsync -av wordpress/* /var/www/html/
              chown -R www-data:www-data /var/www/html
              find /var/www/html/ -type d -exec chmod 755 {} \;
              find /var/www/html/ -type f -exec chmod 644 {} \;
              systemctl restart apache2
              EOF

  tags = {
    Name = "wordpress-instance"
  }
}

// Output the instance IP address
output "wordpress_instance_ip" {
  value = aws_instance.wordpress_instance.public_ip
}
