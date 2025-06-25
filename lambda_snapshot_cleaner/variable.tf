variable "retention_days" {
  description = "Nombre de jours de rétention des snapshots"
  type        = number
  default     = 7
}

variable "function_name" {
  description = "Nom de la fonction Lambda"
  type        = string
  default     = "delete_old_snapshots"
}

variable "schedule_expression" {
  description = "Expression cron pour EventBridge"
  type        = string
  default     = "rate(1 day)"
}
