output "instance_details" {
  description = "Details of all EC2 instances"
  value = {
    for name, instance in aws_instance.my_instance : name => {
      public_ip = instance.public_ip
      user      = var.instances[name].user
      os_family = var.instances[name].os_family
    }
  }
}
