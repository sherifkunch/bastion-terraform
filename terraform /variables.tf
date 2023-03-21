variable "location" {
  description = "Default Azure location for resources."
  type        = string
}

variable "subnets" {
  description = "Subnets to be deployed"
  type        = map(any)
}

variable "network_security_group_name" {
  description = "Base NSG name"
  type        = string
}

# variable "route_table_name" {
#   description = "Name of the base route table"
#   type        = string
# }

# variable "route_table_name_jenkins" {
#   description = "Name of the base route table Jenkins AKS"
#   type        = string
# }

variable "project_name" {
  description = "Project name ('cicd'/'imfa'/...)"
  type        = string
}

variable "stage" {
  description = "Name of the deployment stage ('dev'/'qs'/'prod')"
  type        = string
}

variable "infra_base_name" {
  description = "Default base name for infrastructure resources (see https://git.hub.vwgroup.com/CICD-Platform/ioi-base-infrastructure)."
}

#######
# Tags
#######
variable "tag_git_repo" {
  type    = string
  default = ""
}

variable "tag_git_ref" {
  type    = string
  default = ""
}

variable "tag_git_commit" {
  type    = string
  default = ""
}

variable "tag_mid_content_for_gitc_resourcename" {
  description = "Middle part of GITC_ResourceName mandatory tag, it should be contatenated with tag prefix and postfix for every resource"
  type        = string
}

variable "azure_tags_mandatory_default" {
  description = "Map of mandatory tags"
  type        = map(any)
}

variable "azure_tags_custom_default" {
  description = "Map of custom tags"
  type        = map(any)
  default     = {}
}
