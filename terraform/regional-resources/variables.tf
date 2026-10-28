variable "azs" {
  type        = list(string)
  description = "Availability zones"
}

variable "region" {
  type        = string
  description = "Region display name"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateway in VPC"
  default     = false
}

variable "key_name" {
  type        = string
  description = "Key pair name for EC2 instance"
  default     = "mohitd"
}
