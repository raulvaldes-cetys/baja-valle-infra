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

variable "budget_contact_email" {
  description = "Email that receives the budget alerts"
  type        = string
}

variable "monthly_budget_usd" {
  description = "Monthly budget for the resource group"
  type        = number
  default     = 5
}
