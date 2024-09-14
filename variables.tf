variable "billing_account_name" {
  type    = string
  default = "52049891"
}

variable "enrollment_account_name" {
  type    = string
  default = "374297"
}

variable "subscription_name" {
  type    = string
  default = "Spoke MCK Uvance Platform Engineering"
}

variable "subscription_tags" {
  type = map(string)
  default = {
    Department = "Platform Engineering"
    CostCenter = "0000001"
    Project    = "Uvance"
    CreatedBy  = "garrard.kitchen@fujitsu.com"
  }
}

variable "lz_type" {
  type        = string
  description = "Used in tags to show the LZ type is either 'platform' or 'application'."
  default     = "none"
  validation {
    condition     = can(regex("^(platform|application)$", lower(var.lz_type)))
    error_message = "Invalid deployment_type. Allowed values are 'platform', or 'application'."
  }
}

variable "lz_platform_type" {
  type        = string
  description = "Used in tags when lz_type is 'platform'."
  default     = ""
  validation {
    condition     = (lower(var.lz_type) == "platform" && can(regex("^(connectivity|identity|management)$", lower(var.lz_platform_type))) || lower(var.lz_type) == "application" && lower(var.lz_platform_type) == "")
    error_message = "Invalid platform_module value. Allowed values if LZ_TYPE is Platform are 'connectivity', 'identity', or 'management'.  It should be empty if LZ_TYPE is Application."
  }
}