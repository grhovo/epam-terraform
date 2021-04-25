variable "cidr_block" {
  type        = string
  description = "Ip address range for vpc"
}

variable "subnet_block" {
  type        = string
  description = "Ip address range for subnet"
}

variable "all_ips" {
  type        = string
  description = "all IP addreses"
}