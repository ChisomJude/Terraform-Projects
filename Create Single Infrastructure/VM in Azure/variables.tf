variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Azure virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the Azure subnet"
  type        = string
}

variable "security_group_name" {
  description = "Name of the Azure network security group"
  type        = string
}

variable "network_interface_name" {
  description = "Name of the Azure network interface"
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the Azure virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the Azure virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
}
