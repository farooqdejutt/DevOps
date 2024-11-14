provider "aws" {

  region="eu-central-1"
  profile = "default"

}
resource "aws_instance" "terraform_instance" {
  ami = "ami-08ec94f928cf25a9d"
  instance_type = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name = "terraform"
  tags = {
    Name = "Terraform_Instance"
  }
}