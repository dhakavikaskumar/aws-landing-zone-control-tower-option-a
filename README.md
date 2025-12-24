# Option A — Control Tower QuickStart (Template Repo)

This repository is the productized delivery skeleton for **Option A**:

-   AWS Control Tower landing zone (setup + governance steps documented)
-   IAM Identity Center baseline (permission sets + groups + onboarding docs)
-   Central logging/security baseline (CloudTrail/Config/GuardDuty) with simple alerting assets
-   One baseline “golden” VPC pattern in a single workload account
-   Documentation + acceptance evidence pack structure

> This is a **product** repo to deliver a repeatable landing zone baseline.It is **not** an application repository.

---

## Quickstart (for platform owner)

1.  Review and finalize client decisions:

-   `client-bootstrap.yaml`

2.  Follow Control Tower setup steps (manual):

-   `docs/manual-steps-control-tower.md`

3.  Apply Terraform stacks (as in scope):

-   `networking/` (baseline VPC)
-   `workload-baseline/` (optional split-out baseline items)
-   `security-pack/terraform/*` (SNS, budgets, GuardDuty EventBridge rule)

4.  Validate acceptance criteria and capture evidence:

-   `evidence/acceptance-checklist.md`

---

## Repo conventions

### Naming

-   Account names: `<prefix>-log-archive`, `<prefix>-audit`, `<prefix>-workloads-01`
-   OU names: `Security`, `Workloads`
-   Permission sets: `PS-ReadOnly`, `PS-PowerUser-Workloads`, `PS-Admin-BreakGlass`
-   Groups: `aws-readonly`, `aws-workloads-poweruser`, `aws-breakglass-admin`

All core decisions are captured in:

-   `client-bootstrap.yaml`

### Terraform / OpenTofu

This repo is compatible with both:

-   **Terraform** (primary)
-   **OpenTofu** (drop-in for most workflows)

If using Terraform:

-   recommended pin: `.terraform-version` (works with tfenv/asdf)

If using OpenTofu:

-   you can ignore `.terraform-version` and pin tofu separately (e.g., asdf `.tool-versions` if you use asdf)

### State safety

-   Use remote state (S3 + DynamoDB lock) for any shared use.
-   Never commit `terraform.tfstate` or plan files.

---

## How to run (example)

> Replace profile/region with client values.

```bash
aws sso login --profile <workloads-profile>export AWS_PROFILE=<workloads-profile>export AWS_REGION=<home-region>cd networkingterraform initterraform fmt -checkterraform validateterraform plan -out plan.outterraform apply plan.out
```

---

## License

This project is licensed under the Apache License 2.0.

You are free to use, modify, and distribute this repository for commercial or internal purposes.

> This repository is provided as a reference implementation.It does not constitute legal, security, or compliance advice.Users are responsible for validating controls against their own regulatory requirements.