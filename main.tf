module "create_subscription" {
  source  = "gitlab-master.datahubnow.com/terraform/create-subscription/azure"
  version = "0.0.3"

  billing_account_name    = var.billing_account_name
  enrollment_account_name = var.enrollment_account_name
  subscription_name       = var.subscription_name
  subscription_tags       = var.subscription_tags
  lz_type                 = var.lz_type
  lz_platform_type        = var.lz_platform_type
}
