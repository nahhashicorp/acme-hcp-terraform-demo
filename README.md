# ACME HCP Terraform Demo — EC2 App Server (Single Instance)

This repo demonstrates a governed EC2 app server workflow using HCP Terraform:
- Workspaces (team/env isolation)
- VCS-driven runs (PR -> speculative plan)
- Policy-as-code (Sentinel) guardrails
- Secure state and variables (no secrets in GitHub)

## Demo Flow
1) Open a PR changing `instance_type`
2) HCP Terraform posts a speculative plan to the PR
3) Sentinel policy blocks disallowed instance types (e.g., m5.large)
4) Fix PR to allowed type (e.g., t3.small) -> policy passes
5) Merge PR -> apply runs in the workspace
6) View state versions + outputs in HCP Terraform

## Suggested “policy fail” change
Set instance_type to m5.large (fail), then t3.small (pass).
