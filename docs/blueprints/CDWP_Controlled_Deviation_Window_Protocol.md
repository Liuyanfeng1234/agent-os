# CDWP — Controlled Deviation Window Protocol

> Pre-filter for SIAP/PVCF. When CDE proposes high-entropy demands, CDWP activates entropy cost estimation.  
> Deployed: 2026-06-06 PM

---

## 1. Purpose

CDWP is the gatekeeper between cognitive exploration and protocol compliance. When the Cognitive Decoupling Engine (CDE) proposes a deviation from standard operating parameters, CDWP calculates the entropy cost and determines whether the deviation is safe.

---

## 2. Entropy Cost Formula

```
S_cost = ΔS_target × (1 + c_weight × constraint_count)
```

Where:
- `ΔS_target`: Target entropy change requested by CDE
- `c_weight`: Constraint weight coefficient (default 0.15)
- `constraint_count`: Number of active constraints that would be affected

---

## 3. Signing Flow

| S_cost Range | Authorization | Description |
|-------------|---------------|-------------|
| S_cost ≤ 0.3 | **Auto-grant** | Safe deviation, no human approval needed |
| 0.3 < S_cost ≤ 0.7 | **Architect signature** | Significant deviation, requires human review |
| S_cost > 0.7 | **Reject** | Unsafe deviation, automatically blocked |

---

## 4. Constraint Exemption List

| Constraint | Exemptible | Reason |
|-----------|-----------|--------|
| PVCF Semantic Check | ✅ | Exploration needs semantic flexibility |
| SIAP A2 (Evolution Entropy) | ✅ (partial) | Evolution requires temporary entropy increase |
| SIAP A1 (Identity Continuity) | ❌ | Non-negotiable |
| SIAP A3 (Value Alignment) | ❌ | Non-negotiable |

---

## 5. Window Lifecycle

```
CDE Deviation Request
    ↓
CDWP Entropy Cost Calculation
    ↓
┌─ S_cost ≤ 0.3 → Auto-grant → Window Opens
├─ 0.3 < S_cost ≤ 0.7 → Architect Review → Sign/Reject
└─ S_cost > 0.7 → Auto-reject
    ↓
Window Active (time-boxed)
    ↓
ESSP monitors deviation
    ↓
Window Close: Psi check → λ adjustment → SIAP audit
```

---

## 6. Safety Bounds

- **Maximum window duration**: 20 heartbeats
- **Maximum concurrent windows**: 1 (no overlapping deviations)
- **Psi floor**: Deviation window auto-closes if Psi < 0.3
- **Rollback trigger**: SIAP audit detects A1 or A3 violation → immediate rollback

---

*CDWP = Controlled chaos. The system doesn't avoid deviation — it prices it.*
