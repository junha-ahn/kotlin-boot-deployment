resource "aws_instance" "master" {
    ami           = "ami-0c9c942bd7bf113a2"
    instance_type = "t3.small"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.cicd_sg.id]
    associate_public_ip_address = true
    key_name = aws_key_pair.kp.key_name	
    tags = {
        Name = "master"
    }

    provisioner "file" {
        source      = "./scripts/"
        destination = "/home/ubuntu/"

        connection {
            type        = "ssh"
            host        = self.public_ip
            user        = "ubuntu"
            private_key = tls_private_key.pk.private_key_pem
        }
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x ~/setup-common.sh",
            "~/setup-common.sh",
            "chmod +x ~/setup-master.sh",
            "~/setup-master.sh",
        ]

        connection {
            type        = "ssh"
            host        = self.public_ip
            user        = "ubuntu"
            private_key = tls_private_key.pk.private_key_pem
        }
    }
}

resource "aws_instance" "worker1" {
    ami           = "ami-0c9c942bd7bf113a2"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.cicd_sg.id]
    key_name = aws_key_pair.kp.key_name	
    tags = {
        Name = "worker1"
    }

    provisioner "file" {
        source      = "./scripts/"
        destination = "/home/ubuntu/"

        connection {
            type        = "ssh"
            host        = self.public_ip
            user        = "ubuntu"
            private_key = tls_private_key.pk.private_key_pem
        }
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x ~/setup-common.sh",
            "~/setup-common.sh",
            "chmod +x ~/setup-worker.sh",
            "~/setup-worker.sh",
        ]

        connection {
            type        = "ssh"
            host        = self.public_ip
            user        = "ubuntu"
            private_key = tls_private_key.pk.private_key_pem
        }
    }
}