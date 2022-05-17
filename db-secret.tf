resource "random_password" "my-custom-pass" {
  length           = 16
  special          = true
  override_special = "_%@"
}
 
resource "aws_secretsmanager_secret" "my-secret-master-db" {
   name = "masterDb"
}
 
 
resource "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = aws_secretsmanager_secret.my-secret-master-db.id
  secret_string = <<EOF
   {
    "username": "myAdmin",
    "password": "${random_password.my-custom-pass.result}"
   }
EOF
}
 
data "aws_secretsmanager_secret" "my-secret-master-db" {
  arn = aws_secretsmanager_secret.my-secret-master-db.arn
}
 
data "aws_secretsmanager_secret_version" "credentials" {
  secret_id = data.aws_secretsmanager_secret.my-secret-master-db.arn
}
