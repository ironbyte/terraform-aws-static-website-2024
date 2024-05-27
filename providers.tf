provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      "Name"        = "${var.namespace}-${var.environment}"
      "Environment" = var.environment
      "Terraform"   = "true"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1"
  alias   = "aws_us_east_1"

  default_tags {
    tags = {
      "Name"        = "${var.namespace}-${var.environment}"
      "Environment" = var.environment
      "Terraform"   = "true"
    }
  }
}

provider "cloudflare" {
  api_token = var.cf_api_token
}
