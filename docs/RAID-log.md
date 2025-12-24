# RAID Log — Option A Control Tower QuickStart

## Purpose

Track **Risks, Assumptions, Issues, and Decisions** that may impact delivery, acceptance, or ongoing operations.
This is the **client-facing** RAID log (kept clean, actionable, and non-internal).

## How to use

- Update during kickoff + at least **2x/week** during delivery (or whenever something changes).
- Keep entries **actionable**: clear owner, due date, next step, and status.
- Reference supporting docs where relevant:
  - `docs/01-What-We-Built.md`
  - `docs/07-Out-of-Scope-Option-A.md`
  - `evidence/acceptance-checklist.md`

## Status values (recommended)

- **Open** — active item, needs action
- **In Progress** — action underway
- **Blocked** — waiting on dependency
- **Resolved** — completed/closed (keep for record)

---

## RAID Table (Stable Format)

> **Type:** R = Risk, A = Assumption, I = Issue, D = Decision

|    ID | Type | Title                                                   | Description                                                                                                                                                             | Impact | Owner                              | Due Date   | Status | Next Step                                                                  | References                                                                  |
| ----: | :--: | ------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ | ---------------------------------- | ---------- | ------ | -------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| R-001 |  R   | Single-region constraint may conflict with future needs | Option A is delivered in a**single Control Tower home region**. If future services require other regions, additional governance (SCP allow-list changes) may be needed. | Medium | Client Platform Owner              | 2025-**-** | Open   | Confirm if any near-term workloads need non-home-region deployment.        | `docs/manual-steps-control-tower.md`, `docs/decisions.md`                   |
| R-002 |  R   | Root MFA custody process not finalized                  | Root MFA for each core account requires a custody model (hardware keys vs vault device) and a 2-person approval rule.                                                   | High   | Client Security Owner              | 2025-**-** | Open   | Confirm custody model + store root credential entries in client vault.     | `docs/root-account-handling-sop.md`, `client-bootstrap.yaml`                |
| A-001 |  A   | Email aliases are unique and accessible                 | Account Factory requires a**unique email per AWS account** and access to receive AWS verification/security messages.                                                    | High   | Client Platform Owner              | 2025-**-** | Open   | Confirm mailbox owner + validate aliases for core + next workload account. | `docs/account-emails.md`, `client-bootstrap.yaml`                           |
| A-002 |  A   | Identity Center directory used for Option A             | Option A assumes**IAM Identity Center directory** (no external IdP integration/SCIM).                                                                                   | Medium | Client Platform Owner              | 2025-**-** | Open   | Confirm this is acceptable for initial rollout.                            | `identity/identity-defaults.md`, `docs/04-Runbook-Access-Model.md`          |
| I-001 |  I   | Budget/alert emails not confirmed                       | SNS email subscriptions for budgets/alerts must be confirmed via email link; until then, alerts will not deliver.                                                       | Medium | Client Finance Contact             | 2025-**-** | Open   | Confirm subscription emails in mailbox and click “Confirm subscription.”   | `security-pack/runbooks/incident-quick-actions.md`                          |
| I-002 |  I   | Control Tower enrollment pending / failed step          | Account enrollment or landing zone update may show “in progress” or “failed,” blocking downstream steps (Account Factory, SCP attachments, etc.).                       | High   | Consultant + Client Platform Owner | 2025-**-** | Open   | Review Control Tower dashboard, capture error, remediate per AWS guidance. | `evidence/01-control-tower/ct-healthy.png`                                  |
| D-001 |  D   | Control Tower home region selection                     | Selected Control Tower home region:**ap-south-1**.                                                                                                                      | High   | Client Platform Owner              | 2025-**-** | Open   | Confirm and lock home region in`client-bootstrap.yaml`.                    | `client-bootstrap.yaml`, `docs/naming.md`                                   |
| D-002 |  D   | NAT mode for baseline VPC                               | Baseline VPC NAT mode:**single** (cheapest) OR **per_az** (higher HA).                                                                                                  | Medium | Client Platform Owner              | 2025-**-** | Open   | Confirm NAT mode and update tfvars/env files accordingly.                  | `networking/terraform.tfvars.example`, `env/workloads-01/networking.tfvars` |

---

## Change Log (Optional)

Use this section to keep a simple history of major RAID updates.

- 2025-**-**: RAID log created in repo; initial items added.
- 2025-**-**: ********\*\*\*\*********\_\_********\*\*\*\*********
