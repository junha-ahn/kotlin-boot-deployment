resource "aws_instance" "master" {
    ami           = "ami-0c9c942bd7bf113a2"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.cicd_sg.id]
    tags = {
        Name = "master"
    }
}

resource "aws_instance" "worker1" {
    ami           = "ami-0c9c942bd7bf113a2"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.cicd_sg.id]
    tags = {
        Name = "worker1"
    }
}