output "sg_id" {
  value       = aws_security_group.my_sg.id
  description = "The security group identifier returned to callers"
}
