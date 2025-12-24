# Naming Standard (Option A)

## Purpose

Define the standard naming conventions used in **Option A — Control Tower QuickStart** so the build remains consistent and repeatable.

Option A uses short, practical names. Avoid embedding dates.

---

## Client prefix

A short identifier used across names:

- Format: `3–12` chars, lowercase, letters/digits/hyphen
- Examples: `corp`, `acme`, `finco`, `zenpay`
- Rule: Do not change prefix mid-engagement.

---

## AWS accounts (Option A)

### Core accounts

- Log Archive: `<prefix>-log-archive`
- Audit/Security: `<prefix>-audit` _(or `<prefix>-security` if client prefers)_
- Workloads account(s):
  - `<prefix>-workloads-01`
  - `<prefix>-workloads-02` (future)

### OUs

- `Security` (Log Archive + Audit/Security)
- `Workloads` (workload accounts)

---

## Terraform resources (Option A networking)

Use a consistent pattern for Name tags:
`<prefix>-<account>-net-<region>-<component>`

Examples:

- VPC: `<prefix>-workloads-01-net-<region>-vpc`
- IGW: `<prefix>-workloads-01-net-<region>-igw`
- Public subnet AZ-a: `<prefix>-workloads-01-net-<region>-public-a`
- Private subnet AZ-a: `<prefix>-workloads-01-net-<region>-private-a`
- Route tables:
  - `<prefix>-workloads-01-net-<region>-rt-public`
  - `<prefix>-workloads-01-net-<region>-rt-private`

NAT:

- Single NAT: `<prefix>-workloads-01-net-<region>-nat-a`
- Per-AZ NAT: `<prefix>-workloads-01-net-<region>-nat-a`, `...-nat-b`, etc.

Security groups:

- Web SG: `<prefix>-workloads-01-net-<region>-sg-web`
- App SG: `<prefix>-workloads-01-net-<region>-sg-app`
- DB SG: `<prefix>-workloads-01-net-<region>-sg-db`
- Endpoint SG (if used): `<prefix>-workloads-01-net-<region>-sg-endpoints`

---

## Governance artifacts (SCP names)

SCP names should be short, consistent, and versionable:

- `lz-a-deny-log-tamper`
- `lz-a-deny-logarchive-delete`
- `lz-a-deny-security-disable`
- `lz-a-region-allowlist` _(optional)_

---

## Tagging (Option A minimal)

Apply to network resources and Terraform-managed artifacts:

- `Name` = resource name from this standard
- `Environment` = `workloads`
- `ManagedBy` = `terraform`
- `Project` = `landing-zone`
- `Owner` = `platform` _(or client-provided)_

---

## Notes / exceptions

Record deviations here (e.g., client uses different account naming or internal standards).


---

## Terraform input normalization (single "right way")

When filling Terraform `*.tfvars` for this repo, use **only these two naming inputs**:

- `prefix` — the client prefix (e.g., `corp`)
- `account_name` — the **account suffix without the prefix** (e.g., `workloads-01`)

The repo constructs the full AWS account name as:

- Full account name: `<prefix>-<account_name>` (example: `corp-workloads-01`)

This avoids duplication like `corp-corp-workloads-01`.
