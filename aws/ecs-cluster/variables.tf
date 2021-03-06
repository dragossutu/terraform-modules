variable "aws_region" {
  description = "AWS region for provider"
}

variable "cluster_name" {
  description = "ECS Cluster name"
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
