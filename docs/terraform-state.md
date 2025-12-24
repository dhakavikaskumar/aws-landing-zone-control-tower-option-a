# Terraform State (Option A)

## Purpose

Document the recommended Terraform state pattern for Option A:

- **Remote state** in S3
- **State locking** using DynamoDB
- Minimal operational guidance to prevent collisions and drift

This is a recommendation even if the client chooses to run Terraform locally at first.

---

## Recommended default (remote state)

### Why remote state

- Prevents multiple people from overwriting state
- Enables consistent, repeatable Terraform runs
- Supports future upgrades (Option B/C) without rework

### Default naming

Use these patterns (adjust only if client has standards):

- S3 bucket:
  - `tfstate-<prefix>-<account_id>-<region>`
- DynamoDB table:
  - `tf-lock-<prefix>-<region>`

Example:

- `tfstate-corp-123456789012-ap-south-1`
- `tf-lock-corp-ap-south-1`

---

## S3 bucket settings (recommended)

- Block Public Access: **ON**
- Encryption: **ON**
- Versioning: **ON**
- Access policy: restrict to platform admins / Terraform runner roles
- Lifecycle: optional (keep versions long enough to recover state)

---

## DynamoDB table settings (recommended)

- Billing mode: **Pay-per-request**
- Partition key:
  - `LockID` (string)

---

## Backend configuration example

Add (or enable) this in each Terraform root stack (e.g., `/networking`, `/workload-baseline`).

```hcl
terraform {
  backend "s3" {
    bucket         = "tfstate-<prefix>-<account_id>-<region>"
    key            = "networking/terraform.tfstate"
    region         = "<region>"
    dynamodb_table = "tf-lock-<prefix>-<region>"
    encrypt        = true
  }
}
```

Typical keys:

- `networking/terraform.tfstate`
- `workload-baseline/terraform.tfstate`

---

## Operating rules (Option A)

- Always run `terraform plan` before `apply`
- Keep changes small and reviewable
- Never edit state manually
- If state lock is stuck:
  - confirm no one is running Terraform
  - then unlock only with care (document the reason)

---

## If remote state is not used (temporary local state)

Local state is acceptable only for:

- single-person testing
- short-lived proofs of concept

If local state is used:

- do not run Terraform from multiple machines/users
- plan a move to remote state before production changes accumulate
