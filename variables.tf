variable "config_file_location" {
  default = "./config/ioi-dtp-terraform-variables.json"
  type = string
  description = "Config file location"
}

variable "azure-subscription-id" {
  default = "<subscription-id>"
  description = "The if of the azure subscribtion which we have to deploy our resources"
}