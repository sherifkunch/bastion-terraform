variable "config_file_location" {
  default = "./config/ioi-dtp-terraform-variables.json"
  type = string
  description = "Config file location"
}

variable "azure-subscription-id" {
  default = "4307d060-3d4f-42dd-a5f8-5d44cd11f167"
  description = "The if of the azure subscribtion which we have to deploy our resources"
}