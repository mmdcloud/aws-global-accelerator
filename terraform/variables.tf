variable "mumbai_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "nv_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}
