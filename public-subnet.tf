/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

/* Public subnet */
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.default.id
  cidr_block = var.public_subnet_cidr
  #   availability_zone       = var.aws_availability_zones[count.index] // Grabbing the one availability zone
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.default]
  tags = {
    Name = "my public subnet"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "my public RT"
  }
}

/* Associate the routing table to public subnet */
// Below snippet is limited for single public subnet
// But when we will have multiple public subnets then we will use the memthod used for private subnet associations
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
