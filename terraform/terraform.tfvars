vpc_block          = "10.0.0.0/16"
subnet_block       = "10.0.1.0/24"
all_ips            = ["0.0.0.0/0"]
desired_capacity   = 2
min_size           = 1
max_size           = 3
image_type         = "ami-031b673f443c2172c"
instance_type      = "t2.micro"
key_wordpress_name           = "wordpress-key"
