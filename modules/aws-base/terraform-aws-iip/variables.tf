variable "name" {
  description = "Name used for created resources."
  default     = null
  type        = string
}

variable "actions" {
  description = "Actions allowed for this instance profile."
  default     = ["logs:*"]
  type        = list(string)
}

variable "resources" {
  description = "Resources allowed to access by this instance profile."
  default     = ["*"]
  type        = list(string)
}
