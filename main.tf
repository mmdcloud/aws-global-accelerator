module "singapore-resources" {
  source = "./regional-resources"
  azs    = var.singapore_azs
  providers = {
    aws = aws.singapore
  }
}

module "mumbai-resources" {
  source = "./regional-resources"
  azs    = var.mumbai_azs
  providers = {
    aws = aws.mumbai
  }
}

# Global Accelerator Configuration
resource "aws_globalaccelerator_accelerator" "ga" {
  name            = "ga"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "ga_listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.ga.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_endpoint_group" "ga_endpoint_group" {
  listener_arn = aws_globalaccelerator_listener.ga_listener.id

  endpoint_configuration {
    endpoint_id = aws_lb.example.arn
    weight      = 50
  }

  endpoint_configuration {
    endpoint_id = aws_lb.example.arn
    weight      = 50
  }
}
