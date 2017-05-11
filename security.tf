resource "aws_security_group" "internal_access" {
  name        = "main_rds_sg"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "FULL_ACCESS"
  }
}

resource "aws_security_group" "web" {
	name = "acesso_web_padrao"
	description = "Permitir acesso HTTP a instancia"
	vpc_id = "${aws_vpc.main.id}"
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags {
		Name = "PERMISSAO_HTTP"
	}
}

resource "aws_security_group" "ssh" {
	name = "ssh_access"
	description = "Allow SSH inbound"
	vpc_id = "${aws_vpc.main.id}"
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags {
		Name = "acesso_ssh"
	}
}


