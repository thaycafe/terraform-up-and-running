resource "aws_instance" "example" {
  ami                    = "ami-04dd23e62ed049936"
  instance_type          = "t1.micro"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

  user_data_replace_on_change = true

  tags = {
    Name = "Terraform example"
  }
}

resource "aws_security_group" "instance_sg" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The puclic IP address of the server"
}