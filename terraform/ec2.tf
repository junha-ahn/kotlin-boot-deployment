resource "aws_instance" "master" {
    ami           = "ami-0c9c942bd7bf113a2"
    instance_type = "t2.micro"
    tags = {
        Name = "master"
    }
}

resource "aws_instance" "worker1" {
    ami           = "ami-0c9c942bd7bf113a2"
    instance_type = "t2.micro"
    tags = {
        Name = "worker1"
    }
}