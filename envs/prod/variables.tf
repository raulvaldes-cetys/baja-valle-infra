variable "subscription_id" {
  description = "Azure subscription that hosts the project"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westus3"
}

variable "owner" {
  description = "Value of the owner tag"
  type        = string
  default     = "raulvaldes-cetys"
}
