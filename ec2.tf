resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.subnet1.id
  private_ips = ["20.0.1.5"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-002068ed284fb165b"
  instance_type = "t2.micro"
  key_name      = "Nov2021"
  tags = {
    name = "ec2 for vpc"
  }
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
}