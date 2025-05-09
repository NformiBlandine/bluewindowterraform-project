#The name - displayed after the database is create

output "instance_name" {
  value = google_sql_database_instance.mysql_demo_db.name
}
