variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for EKS"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for worker nodes"
  type        = string
}

variable "desired_nodes" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}


