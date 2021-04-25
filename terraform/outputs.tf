


resource "local_file" "hosts" {
 content = templatefile("hosts.tmpl",
 {
  public-ip=azurerm_public_ip.public_ip.ip_address
 }
 )
 filename = "hosts"
}