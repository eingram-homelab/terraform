variable "vm_name_list" {
  description = "List of VM names to create."
  type        = list(string)
}

variable "vm_folder_name" {
  description = "Folder name to place VM in."
  type        = string
}

variable "vsphere_template" {
  description = "Name of the vSphere template to use."
  type        = string
}

variable "is_windows_image" {
  description = "Boolean to indicate if the image is a Windows image."
  type        = bool
}