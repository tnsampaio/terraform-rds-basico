resource "aws_subnet" "subnet_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.subnet_1_cidr}"
  availability_zone = "${var.az_1}"

  tags {
    Name = "main_subnet1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.subnet_2_cidr}"
  availability_zone = "${var.az_2}"

  tags {
    Name = "main_subnet2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main"
  }
}

resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table_association" "subnet_1" {
  subnet_id      = "${aws_subnet.subnet_1.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_route_table_association" "subnet_2" {
  subnet_id      = "${aws_subnet.subnet_2.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_db_subnet_group" "default" {
  name        = "redmine_subnet_group"
  description = "Redmine subnets"
  subnet_ids  = ["${aws_subnet.subnet_1.id}", "${aws_subnet.subnet_2.id}"]
}