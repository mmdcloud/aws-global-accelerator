module "nv-resources" {
  source = "./regional-resources"
  azs    = var.nv_azs
  region = "North Virginia"
  providers = {
    aws = aws.nv
  }
}

module "mumbai-resources" {
  source = "./regional-resources"
  azs    = var.mumbai_azs
  region = "Mumbai"
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
  listener_arn          = aws_globalaccelerator_listener.ga_listener.id
  endpoint_group_region = "us-east-1"
  endpoint_configuration {
    client_ip_preservation_enabled = true
    endpoint_id                    = module.nv-resources.instance_arn
    weight                         = 50
  }
}

resource "aws_globalaccelerator_endpoint_group" "ga_endpoint_group2" {
  listener_arn          = aws_globalaccelerator_listener.ga_listener.id
  endpoint_group_region = "ap-south-1"
  endpoint_configuration {
    client_ip_preservation_enabled = true
    endpoint_id                    = module.mumbai-resources.instance_arn
    weight                         = 50
  }
}
