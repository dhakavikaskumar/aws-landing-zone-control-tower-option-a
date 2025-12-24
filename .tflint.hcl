# .tflint.hcl
# Minimal, low-noise TFLint config for a product template repo.

config {
  format          = "compact"
  call_module_type = "all"
}

# Core Terraform hygiene rules
rule "terraform_required_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_unused_required_providers" {
  enabled = true
}

# AWS provider ruleset (recommended)
plugin "aws" {
  enabled = true
  version = "0.37.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
