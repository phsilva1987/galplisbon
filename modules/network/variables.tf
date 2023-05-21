variable "Network_CIDR" {
  description = "Set the IP address configuration."
  type        = string
}

variable "N_subnets" {
  description = "Set the total subnets."
  type        = number
}

variable "Name" {
  description = "Set the name."
  type        = string
}

variable "Tags" {
  description = "Set the tags"
  type        = map(string)
}
