variable "config_file_location" {
  default = "./config/ioi-dtp-terraform-variables.json"
  type = string
  description = "Config file location"
}

variable "azure-subscription-id" {
  default = "46812a1d-cbe8-41ec-8552-79a227e1e99d"
  description = "The if of the azure subscribtion which we have to deploy our resources"
}