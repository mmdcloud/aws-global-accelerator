# -----------------------------------------------------------------------------------------
# VPC Configuration
# -----------------------------------------------------------------------------------------
module "vpc" {
  source                  = "../modules/vpc"
  vpc_name                = "vpc"
  vpc_cidr                = "10.0.0.0/16"
  azs                     = var.azs
  public_subnets          = var.public_subnets
  private_subnets         = var.private_subnets
  database_subnets        = []
  enable_dns_hostnames    = true
  enable_dns_support      = true
  create_igw              = true
  map_public_ip_on_launch = true
  enable_nat_gateway      = true
  single_nat_gateway      = false
  one_nat_gateway_per_az  = true
  tags = {
    Name = "vpc"    
  }
}

# Security Group Creation
module "security_group" {
  source = "../modules/security-groups"
  name   = "security-group"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      description     = "ALL Traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "tcp"
      security_groups = []
      cidr_blocks     = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      description     = "Allow outbound traffic to al"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
  tags = {
    Name = "security-group"
  }
}

data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

data "aws_key_pair" "key_pair" {
  key_name = "maxmaxkeypair"
}

# EC2 Instance
module "ec2_instance" {
  source = "../modules/ec2"

  instance_name               = "EC2 Machine"
  ami_id                      = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.key_pair.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  security_group_ids          = [module.security_group.id]
  associate_public_ip_address = true
  monitoring                  = true

  metadata_options = {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data                   = base64encode(templatefile("${path.module}/../files/user_data.sh", {
    region  = var.region
  }))

  tags = {
    Name    = "ec2-instance"
  }
}