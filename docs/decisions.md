# Decision Log (Option A)

## Purpose

Capture key decisions made during delivery so there is no ambiguity later.

**How to use**

- Add a new entry whenever a decision affects scope, security posture, cost, or future upgrades.
- Keep entries short and factual.
- Link to evidence (screenshots, tickets) when available.

---

## Decision template

Copy/paste this block for each decision:

- **ID:** DEC-###
- **Date (YYYY-MM-DD):**
- **Decision:**
- **Context:** (why this decision was needed)
- **Options considered:**
- **Chosen option:**
- **Impact:** (cost/security/ops)
- **Owner/Approver:**
- **Notes/Evidence:** (links, screenshots, ticket number)

---

## Decisions

### DEC-001 — Control Tower home region

- **Date (2025-12-24):**
- **Decision:** Choose Control Tower home region
- **Options considered:**
- **Chosen option:** `ap-south-1`
- **Impact:** Single region for governance; affects where Control Tower is operated
- **Owner/Approver:** Client Platform Owner
- **Notes/Evidence:**

### DEC-002 — NAT mode for baseline VPC

- **Date (2025-12-24):**
- **Decision:** Choose NAT mode (`single` vs `per_az`)
- **Options considered:** `single` (lower cost), `per_az` (higher HA, higher cost)
- **Chosen option:** `single`
- **Impact:** Private subnet egress resilience and monthly cost
- **Owner/Approver:** Client Platform Owner
- **Notes/Evidence:**

### DEC-003 — Region restriction allow-list (Workloads OU)

- **Date (2025-12-24):**
- **Decision:** Apply region allow-list SCP to Workloads OU (Yes/No)
- **Options considered:** enabled vs disabled
- **Chosen option:** `enabled`
- **Impact:** Controls where workloads can be deployed; may affect some services/teams
- **Owner/Approver:** Client Platform Owner
- **Notes/Evidence:**

### DEC-004 — S3 account-level public access block

- **Date (2025-12-24):**
- **Decision:** Enable S3 account-level Public Access Block in all accounts (Yes/No)
- **Options considered:** enabled vs disabled
- **Chosen option:** `enabled`
- **Impact:** Prevents accidental public buckets; may require exceptions for public content hosting
- **Owner/Approver:** Client Platform Owner
- **Notes/Evidence:**
