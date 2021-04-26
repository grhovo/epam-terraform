resource "local_file" "wp-config" {
 content = templatefile("wp-config.php.tmpl",
 {
  db_name=var.dbname
  db_username=var.username
  db_user_pass=var.password
  db_address=aws_db_instance.wordpress_rds.address
 }
 )
 filename = "../wordpress/templates/wp-config.php"
}

