# Root Account Handling SOP (Option A)

## Purpose

Define a simple, consistent process to **minimize and control root usage** across the Option A accounts.

Root should be used only for:

- initial setup tasks that require root
- billing/support configuration where required
- emergency recovery

All normal work should use IAM Identity Center roles.

---

## Accounts in scope

- Management (payer)
- Log Archive (`<prefix>-log-archive`)
- Audit/Security (`<prefix>-audit` or `<prefix>-security`)
- Workloads (`<prefix>-workloads-01`)

---

## Standard requirements (Option A)

### 1) Root MFA must be enabled

- MFA must be enabled on root for **every account**
- Recommended factor:
  - Authenticator app OR hardware key
- Custody model (recommended):
  - Two-person custody (Platform Owner + Security Owner)

### 2) No root access keys

- Root access keys should not exist
- If found, delete them immediately after confirming no dependency

### 3) Alternate contacts must be set

Set in each account:

- Security contact
- Operations contact
- Billing contact

### 4) Root credentials storage

Store root credentials in an approved vault/password manager:

- Root email
- Root password
- MFA recovery codes / device custody details
- AWS account ID
- Support plan details (if applicable)

---

## Procedure — per account checklist

Repeat for each account listed above.

1. **Enable root MFA**
   - IAM console → Security credentials → MFA
2. **Confirm no root access keys**
   - IAM console → Security credentials → Access keys
3. **Set alternate contacts**
   - Account settings → Alternate contacts
4. **Store root credential details**
   - Save to client vault/password manager
5. **Document completion**
   - Update the evidence section below

---

## When root can be used (allowed cases)

- Initial setup that cannot be done through roles
- Support/billing tasks requiring root
- Emergency recovery when all admin paths are broken

**All usage must be recorded** (ticket/incident note) with:

- who used root
- why
- time window
- what changed

---

---

## Breakglass escalation (Option A)

Use this escalation path in incidents or urgent operational recovery:

1. **Use BreakGlass first (preferred)**

   - Sign in via **IAM Identity Center** and assume **`PS-Admin-BreakGlass`** from the `aws-breakglass-admin` group (membership limited to the named `breakglass_contacts`).
   - Perform the **minimum** change required to restore safe operations.
   - Record the action window + reason (ticket/incident note).

2. **If blocked by a guardrail/SCP**

   - Escalate to the Platform Owner + Security Owner for approval.
   - **Temporarily detach** the relevant SCP (only as long as necessary), perform the action, then **reattach**.
   - Document: approver(s), timestamps, and what was changed.

3. **If BreakGlass is unavailable (SSO outage / roles broken)**
   - Use **root** for the specific account as the **last resort**.
   - Follow the “When root can be used” rules below and record full details.

### Two-person custody (how it works in practice)

Option A recommendation: **2-person rule for access to root credentials + root MFA**.

- **Approval rule:** every root or break-glass use requires **two named people** to approve (Platform Owner + Security Owner).
- **Execution rule:** **one person can execute** the actions, but the second person must:
  - be present (live call / screen-share) **or**
  - provide explicit written approval (ticket/incident note) before access and acknowledge after completion.
- **Credential/MFA custody model (recommended):**
  - **Root email**: client-controlled shared mailbox (e.g., `aws@clientdomain.com`) with restricted access.
  - **Root password**: stored **only** in the client’s approved vault/password manager (no personal copies).
  - **Root MFA** (choose one standard and stick to it):
    - **Preferred:** register **two hardware security keys** to root; store one with each custodian in separate locked storage.
    - **Acceptable:** a dedicated “vault device” (phone) with the authenticator app, stored in an office safe; access requires both custodians to be present.
  - **Recovery codes**: stored in the vault entry (ideally with dual-control / approval workflow if the vault supports it).
- **Post-action**:
  - Record who accessed what, why, and what changed.
  - Rotate credentials if policy requires (at least consider password rotation after root use).
  - Put hardware key back into storage.

### Option A application (clear + short)

- Normal operations: **SSO (ReadOnly/PowerUser)**.
- Emergencies: **BreakGlass (SSO admin)** for fast recovery.
- Only if BreakGlass cannot be used: **Root** (per-account) with **two-person custody** and full logging notes.

## Evidence (completion record)

Fill this table during delivery:

| Account        | Account ID | Root MFA Enabled | Root Keys Confirmed Absent | Alternate Contacts Set | Vault Location Recorded | Notes |
| -------------- | ---------- | ---------------: | -------------------------: | ---------------------: | ----------------------- | ----- |
| Management     | `<id>`     |         [Yes/No] |                   [Yes/No] |               [Yes/No] | `<vault path>`          |       |
| Log Archive    | `<id>`     |         [Yes/No] |                   [Yes/No] |               [Yes/No] | `<vault path>`          |       |
| Audit/Security | `<id>`     |         [Yes/No] |                   [Yes/No] |               [Yes/No] | `<vault path>`          |       |
| Workloads-01   | `<id>`     |         [Yes/No] |                   [Yes/No] |               [Yes/No] | `<vault path>`          |       |

---

## Common mistakes

- Leaving root MFA disabled “for later”
- Sharing root MFA with too many people
- Creating root access keys for automation (do not do this)
