provider "aws" {
  region     = "${var.aws_region}"
  secret_key = "${var.password}"
  access_key = "${var.username}"
}



resource "aws_vpc" "main" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = 1

  tags {
    Name = "main"
  }
}


resource "aws_db_instance" "banco1" {
  depends_on             = ["aws_security_group.internal_access"]
  identifier             = "banco1"
  allocated_storage      = "20"
  engine                 = "postgres"
  instance_class         = "db.t2.micro"
  name                   = "banco1"
  username               = "admbanco1"
  password               = "1234AAAAbbbb"
  vpc_security_group_ids = ["${aws_security_group.internal_access.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.default.id}"
  skip_final_snapshot    = true
  #multi_az               = true
  backup_retention_period = 30
  maintenance_window      = "Mon:00:00-Mon:01:00"
}

resource "aws_instance" "instancia_ec2" {
  count = "${var.inst_count}"
  ami           = "ami-80086dec"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.subnet_1.id}"

  vpc_security_group_ids = ["${aws_security_group.ssh.id}", "${aws_security_group.web.id}"]

  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.admin.id}"

  tags {
    name = "instancia_${count.index}"
  }
}


resource "aws_key_pair" "admin" {
  key_name   = "Admin's ssh key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAomgAhg2r3ZXXeh8trnTjAnR7F53VcMA1eHkBRgSKW2n+i0sEXXKIt9bGs4JXaqdYFPnpIfx1gGSayUBpZtGZue+d1yy3CC/V9/7rG7wwJGTjTXb843PQcQqFUFVx2TN6iEDz8YlYgFF42vR25k75W3DbnLSNolHYPE5H/gT0T18iBwcK70BH6cz2lILCOYTDQsozEt8m3ZbOi6HK9B8Lev9Gymh/RPISiigH6JfnsbTLBUMd2EiuSUBXiQPIGJ7Y2tCGyXcpmF41ax3cp56V6ByoddjmnpjvDSB+0Qjb9SBXlOIONR93ay3/hI+YwZz7K7cVXYBpBwA3fY+qTIIf Tiago N Sampaio"
}