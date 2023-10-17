// we can Create the Data Object that holds the ubuntu 20.04 server AMI but we are not doing that. while we will use the existing one

resource "aws_db_instance" "rds_db" {
  // Here we have allocated 10
  allocated_storage = var.settings.database.allocated_storage

  // In ourcase the engine is mySQL
  engine = var.settings.database.engine

  engine_version = var.settings.database.engine_version

  instance_class = var.settings.database.instance_class

  // Here I have no invoked the db_name, Which creates when this instance run
  username = var.db_username

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.rds_db_subnet_group.id

  vpc_security_group_ids = [aws_security_group.db_server_sg.id]

  skip_final_snapshot = var.settings.database.skip_final_snapshot
}

resource "aws_instance" "db_instance" {
  count         = var.settings.web_app.count
  ami           = var.amis[var.region]
  instance_type = var.settings.web_app.instance_type
  subnet_id     = aws_subnet.public.id
  #   security_groups   = [aws_security_group.default.id]
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "rds_instance_${count.index}"
  }
}

resource "aws_eip" "db_instance_eip" {
  count    = var.settings.web_app.count
  instance = aws_instance.db_instance[count.index].id

  vpc = true
  tags = {
    Name = "db_instance_eip_${count.index}"
  }
}
