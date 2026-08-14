resource "aws_db_instance" "default" {
  identifier           = "terraform-rds-demo"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp3"

  db_name              = "mydb"
  username             = "foo"
  password             = "must_be_eight_characters"

  skip_final_snapshot  = true
  publicly_accessible  = false

  tags = {
    Name        = "terraform-rds-demo"
    Environment = "development"
  }
}