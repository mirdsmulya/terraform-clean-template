variable "cluster_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "subnet_ip_staging" {
  default = "10.10.0.0/24"
}

variable "subnet_ip_production" {
  default = "10.20.0.0/24"
}

variable "ip_range_pods_staging" {
  default = "192.168.0.0/18"
}

variable "ip_range_svc_staging" {
  default = "192.168.64.0/18"
}

variable "ip_range_pods_production" {
  default = "172.16.0.0/18"
}

variable "ip_range_svc_production" {
  default = "172.16.64.0/18"
}