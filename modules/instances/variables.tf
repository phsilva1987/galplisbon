variable "Name" {
  description = "infrastructure name."
  type        = string
}

variable "Network" {
  description = "A map with all information."
  type        = map(any)
}

variable "Image" {
  description = "The AMI ID."
  type        = string
}

variable "SSH_key_Content" {
  description = "The SSH key to connect to all instances."
  type        = string
}

variable "SSH_source" {
  description = "The source IP address that is allowed to connect to the instances over SSH."
  type        = string
}
