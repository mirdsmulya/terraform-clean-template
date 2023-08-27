# ----------------------------
# General Variable
# ----------------------------
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
}

variable "env" {
  type = string
}


# ----------------------------
# Cloudsql Related Variable
# ----------------------------
variable "cloudsql_name" {
  type = string
}

variable "delete_protection" {
  type = bool
  default = true
}

variable "database_version" {
  type = string
}

variable "tier_spec" {
  type = string
}

variable "availability_type" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "initial_db_name" {
  type = string
}

variable "initial_db_user" {
  type = string
}