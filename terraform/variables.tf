variable "vpc_block" {
  type        = string
  description = "Ip address range for vpc"
}

variable "subnet_block" {
  type        = string
  description = "Ip address range for subnet"
}

variable "all_ips" {
  type        = list(string)
  description = "all IP addreses"
}

variable "image_type" {
  type        = string
  description = "Image id for wordpress"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "desired_capacity" {
  type = number
  description = "Desired capacity of asg"
}

variable "min_size" {
  type = number
  description = "Minimum capacity of asg"
}

variable "max_size" {
  type = number
  description = "Maximum capacity of asg"
}
variable "key_wordpress_name" {
  type = string
  description = "Key name"
}