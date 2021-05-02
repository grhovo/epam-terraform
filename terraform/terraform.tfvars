vpc_block          = "10.0.0.0/16"
subnet_block_1     = "10.0.1.0/24"
subnet_block_2     = "10.0.2.0/24"
subnet_block_3     = "10.0.3.0/24"
all_ips            = ["0.0.0.0/0"]
desired_capacity   = 2
min_size           = 1
max_size           = 3
image_type         = "ami-031b673f443c2172c"
instance_type      = "t2.micro"
key_wordpress_name = "wordpress-key"
storage            = 10
db_instance_type   = "db.t3.micro"
dbname             = "wordpress_db"
username           = "wordpress_user"
password           = "my_password"
wordpress_pub_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDtCgutm0RsrEJ/3RUBfoLESUU7NC+CTDDY1YFcwQQBroT9H4OM98K9tYVOXxtZUkAjHOurPjwyY2FMKDhtTzezzY/CRZw4ShZRsCmn+O0A46sLt/Yrsn4hxyXYWqMDPu0QOh6eUhi0iEGaoQT3dr0uu266oDB0/RqIpPyA6Havmv9NiBmq3n5uRtJb5FdBgvyvQbY6Y074Icooh0c7ZY1s8+yZ4mI6oo4xfmZpGOjCZ4t57uuiOo5pXcpPlV1NTRflpdYKwlvscK6f8LoQ9qkql780uL5HO8lLySRzwKPvf/oZSuS/YinQf275A4x59tGbmJORsO7WPaFi72mfn/ie4eMwC4KytesyIaBkegwFJaVHeFEsxOO932npk9HUnUGooysmjVmfKscWB8L2vV45WD4McXv4E+JQqbh3iNjDxmoY2lGh2k9uXY3WXQ94slN1VvU2H46KAopgdaakiGv19ghzofQdb3tDwSZy78mEKbdZvCt2PKjt9/inYA7UP8k= hovo@ubuntu"