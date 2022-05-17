locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.credentials.secret_string)
}
