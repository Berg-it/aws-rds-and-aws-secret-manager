resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["subnet-111"]
}

resource "aws_rds_cluster" "first-db" { 
  cluster_identifier = "democluster"
  database_name = "maindb"
  master_username = local.db_creds.username
  master_password = local.db_creds.password
  port = 5432
  engine = "aurora-postgresql"
  engine_version = "11.6"
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  storage_encrypted = true
}
 
 
resource "aws_rds_cluster_instance" "my-instances" { 
  count = 2
  identifier = "myinstance-${count.index + 1}"
  cluster_identifier = "${aws_rds_cluster.first-db.id}"
  instance_class = "db.r4.large"
  engine = "aurora-postgresql"
  engine_version = "11.6"
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  publicly_accessible = true
}
