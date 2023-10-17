/* Default security group */
resource "aws_security_group" "default" {
  name        = "default-automated-vpc"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default"
  }
}

/* Security group for the nat server */
resource "aws_security_group" "nat" {
  name        = "nat-automated-SG" // Haard_changed
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat"
  }
}

/* Security group for the web */

// This security groups we will attach to the app servers
resource "aws_security_group" "web" {
  name        = "web-automated-SG" // Haard Changed
  description = "Security group for web that allows web traffic from internet"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // I am also adding the port 22 traffic of SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // I faced the issue using the instance for some operations so I added below outbound rule to resolve. Let see what happen
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic to anywhere on the internet
  }
  tags = {
    Name = "web"
  }
}


//This security group we willl attach to the DB_server or RDS security Group

resource "aws_security_group" "db_server_sg" {
  name        = "db_server_sg"
  description = "Security Group for RDS Databases"
  vpc_id      = aws_vpc.default.id

  ingress {
    description     = "Allow MySQL traffic from only the websecurity group"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  tags = {
    Name = "db_server_sg"
  }

}
