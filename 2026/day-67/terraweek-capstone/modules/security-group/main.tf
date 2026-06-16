resource "aws_security_group" "my_sg" {
  name        = "${var.project_name}-${var.environment}-SG"
  description = "Security group with dynamic allowed ports"
  vpc_id      = var.vpc_id

  # Dynamic Block iterates over the variable array to construct individual items
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Shorthand syntax mapping to all protocols and ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-SG"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

