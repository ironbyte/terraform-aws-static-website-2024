# Terraform AWS Static Website 2024 🚀🚀🚀

This simple Terraform project sets up a static website on AWS. It includes creating a private S3 bucket for website assets, a CloudFront distribution, and a Cloudflare record.

The project also implements security best practices by using Origin Access Control (OAC) as [recommended by AWS](https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/) to grant CloudFront access to the S3 origin.

Cloudflare is chosen over AWS Route 53/WAF services for its legendary DDoS protection and because it's free to use. Why not? 😉 Remember YOLO.

## Quick Start - Dev

- Create a `env.dev.tfvars` file in the root directory and add the following variables:

```hcl
namespace      = "experimental-app-1"
environment    = <BRING_YOUR_OWN>
cf_zone_id     = <BRING_YOUR_OWN>
cf_account_id  = <BRING_YOUR_OWN>
cf_api_token   = <BRING_YOUR_OWN>
cf_domain_name = <BRING_YOUR_OWN>
aws_profile    = <BRING_YOUR_OWN>
aws_region     = <BRING_YOUR_OWN>
```

- Run the following commands:

```bash
terraform init
terraform plan -var-file=env.dev.tfvars
terraform apply -var-file=env.dev.tfvars
```

- Copy contents of the static_website_assets folder to the S3 bucket created by Terraform.

- Visit the CloudFront domain name/Cloudflare hostname in your browser to see the website.

## Notes regarding Cloudflare

By default, Cloudflare universal SSL certificates (which are free, bro) only cover your apex domain and one level of subdomain. Source: [Cloudflare](https://support.cloudflare.com/hc/en-us/articles/115000479507-Understanding-Origin-CA-Root-Certificates)
