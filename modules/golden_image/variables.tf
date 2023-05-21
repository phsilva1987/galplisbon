variable "Name" {
  description = "The name of the Golden Image"
  type        = string
}

variable "Manifest_path" {
  description = "The path where the manifest file is dumped by the packer build command."
  type        = string
}
