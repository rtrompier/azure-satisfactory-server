variable "deploy_vm" {
  description = "VM should be deployed ?"
  type        = bool
  default     = true
}

variable "disk_lun" {
  description = "Disk LUN"
  type        = string
  default     = "10"
}
