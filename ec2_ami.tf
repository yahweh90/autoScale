resource "aws_instance" "example_instance" {
  ami                         = "ami-06b21ccaeff8cd686" # Specify the base AMI ID
  instance_type               = "t2.micro"     # Specify the instance type
  associate_public_ip_address = true           # Adjust as needed
  subnet_id                   = aws_subnet.public_subnet[0].id


  user_data = filebase64("userdata.sh")
  tags = {
    Name = "example-instance"
  }

}

resource "aws_ami_from_instance" "example_ami" {
  name               = "custom-ami"
  source_instance_id = aws_instance.example_instance.id

}