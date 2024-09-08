# ----------------------------------------------------------------------------
# Data
# ----------------------------------------------------------------------------
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# ----------------------------------------------------------------------------
# Global Tags
# ----------------------------------------------------------------------------
locals {
  required_tags = {
    Region      = data.aws_region.current.name
    Environment = "${var.tags.env}"
    Project     = "${var.tags.prj}"
    AppliedBy   = split(":", data.aws_caller_identity.current.user_id)[1]
    Terraform   = "true"
  }
  optional_tags = {
    for k, v in var.tags :
    k => v if k != "Region" && k != "Environment" && k != "Project" && k != "AppliedBy" && k != "Terraform"
  }
}
