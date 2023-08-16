provider "aws" {
    region = "us-east-1"
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.1"
  ami=var.ami_id
  instance_type=var.inst_type
  count=var.no_of_instances
  associate_public_ip_address = false
  tags={
    Name="VM - ${count.index}"
  }
}
