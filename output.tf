output "instance_private_IP" {
  value = aws_instance[*].private_ip
}
