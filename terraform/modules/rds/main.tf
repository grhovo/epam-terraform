resource "aws_db_subnet_group" "db_subnet" {
  name       = "subnet_db_group"
  subnet_ids = var.subnet_db
}
resource "aws_db_instance" "wordpress_rds" {
  allocated_storage    = var.storage
  engine               = "mysql"
  instance_class       = var.db_instance_type
  name                 = var.dbname
  username             = var.username
  password             = var.password
  vpc_security_group_ids = var.security_group_db
  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
  skip_final_snapshot  = true
}