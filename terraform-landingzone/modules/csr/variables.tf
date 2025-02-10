variable "instance_count" {
  description = "Number of Cisco routers to create"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Instance type for Cisco router"
  type        = string
  default     = "c5.4xlarge"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where the instance will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID to attach"
  type        = string
}

variable "volume_size" {
  description = "EBS Volume Size"
  type        = number
  default     = 50
}

variable "ami_owner" {
  description = "AMI Owner ID (AWS Marketplace)"
  type        = string
  default     = "aws-marketplace"
}

variable "ami_name" {
  description = "AMI Name filter for Cisco 8000"
  type        = string
  default     = "cisco-8000-router-*"
}
