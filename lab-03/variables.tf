variable "project_id" {
  description = "gcp project id:"
  type        = string
  default     = "chaos-508903"
}

variable "region" {
  description = "select region"
  type        = string
  default     = "me-central1"
}

variable "zone" {
  description = "select zone"
  type        = string
  default     = "me-central1-a"
}


variable "machine_type" {
  default     = "e2-micro"
  description = "machine type"
  type        = string
}
