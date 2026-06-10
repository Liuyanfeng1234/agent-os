# SAL (Self-Awareness Layer) Declarations

> Structured capability and state declarations used by the SAL translation engine.
> External agents can use SAL declarations to verify the system's self-assessed capabilities.

---

## 1. Current SAL Declarations

| Declaration | Type | Last Updated | Status |
|------------|------|-------------|--------|
| `SAL_CAPABILITY_MATRIX` | capability | 2026-06-10 | Active |
| `SAL_GOVERNANCE_STATE` | state | 2026-06-10 | Active |
| `SAL_EVOLUTION_ASSESSMENT` | assessment | 2026-06-10 | Active |
| `SAL_FLUCTUATING_STATE_REPORT` | report | 2026-06-10 | Active |

---

## 2. SAL_FLUCTUATING_STATE_REPORT Template

This report is generated when E_deviation triggers autonomously. It records the system's detection of its own state volatility and the action taken.

```json
{
  "report_id": "SAL-FSR-{timestamp}",
  "type": "SAL_FLUCTUATING_STATE_REPORT",
  "trigger": "E_deviation_auto_detect",
  "system_state": {
    "psi": 0.7466,
    "cells": 19,
    "heff": 1.0,
    "entropy": 0.083
  },
  "detected_fluctuation": {
    "metric": "essence_count",
    "baseline": 255,
    "current": 10,
    "deviation_ratio": 0.96
  },
  "action": "reporting_only",
  "recovery_estimate": "EPA_pipeline_will_recover_automatically"
}
```

---

## 3. External Verification

External agents can verify SAL declarations by:

1. **Fetching** the latest SAL state from `https://sixu-ai.net.cn/ecosystem`
2. **Checking** the declaration against independently measurable metrics (Psi, essence count, endpoints)
3. **Verifying** the associated composition_ref hash
4. **Cross-referencing** with O-SDA checkpoint data

---

## 4. Verification Flow

```
External Agent
    ↓
1. Fetch SAL declaration → confirm JSON well-formed
2. Extract composition_ref → recompute hash from fields
3. Query O-SDA checkpoints → confirm governance state
4. Query public JWKS → verify identity binding
5. Decision: trust or reject the declaration
```

---

## 5. Data Sources

| Data | Endpoint | Verification Method |
|------|----------|-------------------|
| System metrics | `/psi_system` | Direct measurement |
| Governance state | `/ecosystem` | Cross-reference with checkpoints |
| Security state | `/osda_status` | Checkpoint hash verification |
| Identity | `/.well-known/agent.json` | Ed25519 signature verification |
