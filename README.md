# AWS IAM Permission Boundary + Security Guardrails (Terraform)

> 🔐 This project demonstrates how to use IAM permission boundaries to prevent privilege escalation, even when AdministratorAccess is granted.

## 🛡️ Overview

This project defines an IAM permission boundary that enforces strict security guardrails across roles and users — even when administrators try to overgrant permissions. All infrastructure is deployed via Terraform.

---

## 🎯 What It Demonstrates

- Permission boundary policy to block risky actions (e.g. `iam:PassRole`, `iam:CreateAccessKey`, `s3:*`)
- IAM role that cannot escalate access even if attached by an admin
- Modular Terraform config for reproducible enforcement

---

## 🔐 Why Permission Boundaries Matter

Most breaches aren’t zero-days — they’re misconfigurations.  
Permission boundaries act as a **failsafe**, preventing accidental or malicious privilege escalation.

Example:  
You give a developer IAM:AdministratorAccess — but the permission boundary prevents them from modifying IAM, creating access keys, or reading sensitive S3 buckets.

---

## 🧱 Stack

- AWS IAM
- Terraform v1.x
- AWS CLI (for testing)

---

## 🗂️ Files

- `main.tf` – Boundary policy + IAM role that uses it
- `boundary-policy.json` – JSON-formatted permissions guardrail
- `variables.tf` – Inputs for resource names
- `outputs.tf` – Useful references

---

## 🧪 Test Flow

1. Deploy with `terraform apply`
2. Go to IAM → Roles → `test-restricted-role`
3. Attach the AWS-managed `AdministratorAccess` policy
4. Try to:
   - Create an IAM access key
   - Attach another IAM policy
   - Modify an S3 bucket policy

All actions should fail — the permission boundary prevents escalation even when full admin is granted

---

## 💡 Bonus Ideas

- Make the boundary reusable across org units or accounts
- Add CloudTrail log validation to confirm blocked actions
- Add CI check to detect boundary drift

---

## 📎 Live Project

[Back to my site → troyrcopeland.com](https://www.troyrcopeland.com)