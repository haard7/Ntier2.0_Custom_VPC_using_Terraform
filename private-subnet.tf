/* Private subnet */
// Here we are defining the whole private subnet group. Becz we have total of 2 subnets
resource "aws_subnet" "private" {

  count = var.subnet_count["private"]


  vpc_id     = aws_vpc.default.id
  cidr_block = var.private_subnet_cidr[count.index]
  // Selecting the AZ for failover and better redundancy
  availability_zone       = var.aws_availability_zones[count.index]
  map_public_ip_on_launch = false
  depends_on              = [aws_instance.nat]
  tags = {
    Name = "private_subnet_${count.index}"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block  = "0.0.0.0/0" // FLAG - for change
    instance_id = aws_instance.nat.id
  }
  tags = {
    Name = "my private RT"
  }
}

/* Associate the routing table to private subnet */
resource "aws_route_table_association" "private" {
  count = var.subnet_count.private
  // grabbing from the list of private subnet we have
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
