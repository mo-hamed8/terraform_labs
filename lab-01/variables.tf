variable "ubuntu_image" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
}

variable "zone" {
  default = "me-central1-a"
}

variable "region" {
  default = "me-central1"
}
variable "project_id" {
  default = "chaos-508903"
}