output "Manifest" {
  description = "The manifest file content."
  value       = data.local_file.manifest.content
}
