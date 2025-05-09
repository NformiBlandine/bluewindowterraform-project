# Resource to create a MySQL database instance on Google Cloud SQL
resource "google_sql_database_instance" "mysql_demo_db" {
  name             = var.name
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
    }
  }
}
