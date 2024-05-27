terraform {
  required_version = ">=1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}
