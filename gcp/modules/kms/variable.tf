# ----------------------------
# General Variable
# ----------------------------
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

# ----------------------------
# KMS Related Variable
# ----------------------------
variable "keyring" {
  type = string
}

variable "keys" {
    type = list
}