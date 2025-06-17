output "public_ip" {
  value = aws_instance.ngnix_instance.public_ip
}

output "instance_id" {
  value = aws_instance.ngnix_instance.id
}