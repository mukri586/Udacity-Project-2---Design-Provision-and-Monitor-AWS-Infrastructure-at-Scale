provider "aws" {
	region = "ca-central-1"
	  	
}


resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0f75c2980c6a5851d"
  instance_type = "t2.micro"
  subnet_id = "subnet-64daa40c"
  
}

resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0f75c2980c6a5851d"
  instance_type = "m4.large"
  subnet_id = "subnet-64daa40c"
  
}