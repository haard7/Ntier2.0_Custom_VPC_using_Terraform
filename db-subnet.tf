
resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name        = "rds_db_subnet_group"
  description = "DB subnet group for tutorial"
  // Since the DB subnet group requires 2 or more subnets, we are going to loop throgh our private subnets in "private" and add them to this rds_db_subnet_group
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]
}
