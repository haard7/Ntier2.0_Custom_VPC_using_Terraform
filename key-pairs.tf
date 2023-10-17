resource "aws_key_pair" "deployer" {
  key_name   = "automated-vpc"
  public_key = file("~/.ssh/id_rsa.pub")
}
