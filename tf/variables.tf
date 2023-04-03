variable "onpremise_location" {
  type        = string
  default     = "northeurope"
  description = "On-premise resources location"
}

variable "onpremise_bgp_asn" {
  type        = number
  default     = 64000
  description = "On-premise BGP ASN"
}

variable "azure_location" {
  type        = string
  default     = "westeurope"
  description = "Azure resources location"
}

variable "azure_bgp_asn" {
  type        = number
  default     = 65000
  description = "Azure BGP ASN"
}

variable "admin_password" {
  description = "Password for all VMs deployed in this lab"
  type        = string
}

variable "vm_size" {
  type        = string
  default     = "Standard_DS1_v2"
  description = "VM Size"
}

variable "vm_os_type" {
  type        = string
  default     = "Windows"
  description = "VM OS Type"
}

variable "vm_os_publisher" {
  type        = string
  default     = "MicrosoftWindowsServer"
  description = "VM OS Publisher"
}

variable "vm_os_offer" {
  type        = string
  default     = "WindowsServer"
  description = "VM OS Offer"
}

variable "vm_os_sku" {
  type        = string
  default     = "2022-datacenter-azure-edition"
  description = "VM OS Sku"
}

variable "vm_os_version" {
  type        = string
  default     = "latest"
  description = "VM OS Version"
}

locals {
  shared-key = "insomealab-shared-key"
}