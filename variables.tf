variable "sgname" {
  description = "this is for security group"
  default     = "prodsg"
}


variable "cidr_ingress_egress" {
  description = "allow anything"
  default     = ["0.0.0.0/0"]
  type        = list(any)
}

variable "subnet_cidr" {
  description = "this is subnet cidr"
  default     = ["20.0.1.0/24"]
  type        = list(any)
}