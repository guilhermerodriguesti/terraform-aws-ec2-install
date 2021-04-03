resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  availability_zone      = var.availability_zone
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.sg1.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.web_ec2.public_ip
    private_key = tls_private_key.key.private_key_pem
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd git -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
    ]
  }
  tags = {
    Name = var.instance_name
  }
}




