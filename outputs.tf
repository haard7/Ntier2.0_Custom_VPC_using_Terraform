output "natIP" {
  value = aws_instance.nat.public_ip
}

output "appservers" {
  value = join(",", aws_instance.app.*.private_ip)
}

output "elbHostname" {
  value = aws_elb.app.dns_name
}

// web server public IP
output "web_public_ip" {
  description = "Public IP address of web server (the instance called db_instance is acting as the web server)"

  value = aws_eip.db_instance_eip[0].public_ip

  depends_on = [aws_eip.db_instance_eip]
}

// Note: the name of instance is db_instance but it acts as a web server which can only communicate with the Database

output "web_public_DNS" {
  description = "The public DNS Address of the web server"

  value      = aws_eip.db_instance_eip[0].public_dns
  depends_on = [aws_eip.db_instance_eip]
}

// DB endpoint output
// It is from rds_db instance which reside in private subnet
output "datababse_endpoint" {
  description = "The endpoint of the Database"

  value = aws_db_instance.rds_db.address
}

output "database_port" {
  description = "the port of the database"
  value       = aws_db_instance.rds_db.port
}
