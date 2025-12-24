# Account Emails (Option A)

## Purpose

Document the **email addressing standard** used to create AWS accounts in this landing zone.

AWS requires a **unique email address per AWS account**. This file records the aliases used and who owns the mailbox.

---

## Standard approach

Use a single “catch-all” mailbox with **plus addressing** (or aliases).

### Base mailbox (owner)

- Base mailbox: `aws@vikaskumardhaka.com`
- Mailbox owner: `Vikas Kumar Dhaka`
- Backup contact: `<name / team>`

**Rules**

- Each AWS account must have a **unique** email address.
- The mailbox must receive:
  - account verification emails
  - billing/security notifications
  - password recovery communications (root email)

---

## Account email aliases

| Account Purpose    | Account Name                                | Account Email Alias                                         |
| ------------------ | ------------------------------------------- | ----------------------------------------------------------- |
| Management (payer) | `Management`                                | `aws+management@vikaskumardhaka.com` _(or client-provided)_ |
| Log Archive        | `<prefix>-log-archive`                      | `aws+log-archive@vikaskumardhaka.com`                       |
| Audit/Security     | `<prefix>-audit` _(or `<prefix>-security`)_ | `aws+audit@vikaskumardhaka.com`                             |
| Workloads 01       | `<prefix>-workloads-01`                     | `aws+workloads-01@vikaskumardhaka.com`                      |

Add new workload accounts as:

- `aws+workloads-02@vikaskumardhaka.com`
- `aws+workloads-03@vikaskumardhaka.com`

---

## Root access custody

For each account, decide and record:

- Who has access to the root mailbox credentials
- Who holds the root MFA device / recovery codes
- Where credentials are stored (password manager/vault)

**Default recommendation:** 2-person custody (Platform Owner + Security Owner).

---

## Notes / exceptions

Record any special cases here (e.g., client cannot use plus addressing, uses Google aliases, uses distribution lists, etc.).
