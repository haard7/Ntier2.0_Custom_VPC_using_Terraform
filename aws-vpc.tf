/* Setup our aws provider */
provider "aws" {

  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# data "aws_availability_zones" "available" {
#   state = "available"
# }

data "aws_availability_zones" "available" {
  state = "available"
}

/* Define our vpc */
resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "automated"
  }
}
