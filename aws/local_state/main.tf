
module "wordpress_terraform" {
  source = "./modules/wordpress_terraform"
  ami_value = "????" 
  instance_type_value = "t2.micro"
}