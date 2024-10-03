variable "adminpc3_image" {
  type        = string
  description = "image of the adminpc3 host"
}

variable "adminpc3_flavor" {
  type        = string
  description = "flavor of the adminpc3 host"
  default     = "d2-2"
}

variable "adminpc3_userdata" {
  type        = string
  description = "Userdata for the adminpc3 virtual machine"
  default     = null
}
