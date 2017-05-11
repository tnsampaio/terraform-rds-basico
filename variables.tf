variable "username"{
    description = "Usuário padrão"
}

variable "password" {
    description = "Senha de acesso"

}

variable "aws_region" {
  default     = "sa-east-1"
  description = "Default AZ Zone"
}

variable "subnet_1_cidr" {
	default     = "172.16.245.0/24"
	description = "subnet padrao na zona primaria"
}

variable "subnet_2_cidr" {
	default     = "172.16.246.0/24"
	description = "Subnet padrao na zona secundaria"
}

variable "az_1" {
	default     = "sa-east-1a"
	description = "Zona de disponibilidade primaria"
}

variable "az_2" {
	default     = "sa-east-1c"
	description = "Zona de disponibilidade secundaria"
}


variable "inst_count" {
	default = 2
	description = "Instancias EC2"
}