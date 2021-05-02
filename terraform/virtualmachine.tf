provider "aws" {
  region = "us-west-1"
}


resource "aws_vpc" "wordpress_vpc" {
  cidr_block           = var.vpc_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_classiclink   = false
  instance_tenancy     = "default"

}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.wordpress_vpc.id
}

resource "aws_subnet" "wordpress_subnet_public" {
  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.subnet_block_1
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1a"
}

resource "aws_subnet" "wordpress_subnet_private_1" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = var.subnet_block_2
  availability_zone = "us-west-1a"
}

resource "aws_subnet" "wordpress_subnet_private_2" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = var.subnet_block_3
  availability_zone = "us-west-1c"
}

resource "aws_route_table" "wordpress_routetable" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.wordpress_subnet_public.id
  route_table_id = aws_route_table.wordpress_routetable.id
}

resource "aws_security_group" "for_instance" {
  name        = "Security group for instance"
  description = "Allow http from vpc and ssh from all world"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.wordpress_vpc.cidr_block]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.all_ips
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.all_ips
  }
  tags = {
    Type  = "web"
    Owner = "wordpress"
  }
}

resource "aws_security_group" "for_lb" {
  name        = "for-lb"
  description = "Allow http from all world"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.all_ips
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.all_ips
  }
  tags = {
    Type  = "web"
    Owner = "wordpress"
  }
}

resource "aws_security_group" "for_db" {
  name        = "for-db"
  description = "Allow db port from all world"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description = "msyql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.all_ips
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.all_ips
  }
  tags = {
    Type  = "db"
    Owner = "wordpress"
  }
}

resource "aws_elb" "wordpress_lb" {
  name            = "wordpress-lb"
  subnets         = [aws_subnet.wordpress_subnet_public.id]
  security_groups = [aws_security_group.for_lb.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
resource "aws_key_pair" "wordpress_key" {
  key_name   = var.key_wordpress_name
  public_key = var.wordpress_pub_key
}

resource "aws_launch_template" "wordpress_lt" {
  name_prefix            = "wordpress-lt"
  image_id               = var.image_type
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.for_instance.id]
  key_name               = var.key_wordpress_name
  tags = {
    Type  = "web"
    Owner = "wordpress"
  }
}

resource "aws_autoscaling_group" "wordpress_asg" {
  vpc_zone_identifier = [aws_subnet.wordpress_subnet_public.id]
  load_balancers      = [aws_elb.wordpress_lb.id]
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.wordpress_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Type"
    value               = "web"
    propagate_at_launch = true
  }
  tag {
    key                 = "Owner"
    value               = "wordpress"
    propagate_at_launch = true
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ec2.py ../playbook.yaml"
  }
}

module "rds" {
  source = "./modules/rds"

  storage           = var.storage
  db_instance_type  = var.db_instance_type
  dbname            = var.dbname
  username          = var.username
  password          = var.password
  subnet_db         = [aws_subnet.wordpress_subnet_private_1.id, aws_subnet.wordpress_subnet_private_2.id]
  security_group_db = [aws_security_group.for_db.id]
}

