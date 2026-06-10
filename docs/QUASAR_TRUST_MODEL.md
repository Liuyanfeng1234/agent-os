# QUASAR Trust Model v1.0

> Four-tier behavioral trust model with evidence-based transitions,
> temporal decay, and SHA-256 digest verification.

---

## 1. Four Trust Tiers

| Tier | Threshold | Description |
|------|-----------|-------------|
| TRUSTED | ≥0.75 | Agent consistently produces valid, verifiable actions |
| NEUTRAL | 0.50–0.75 | Agent operates normally, no trust concerns |
| WATCH | 0.25–0.50 | Agent shows anomalous patterns, under increased scrutiny |
| QUARANTINE | <0.25 | Agent actions are blocked pending human review |

---

## 2. Evidence-Based Transitions

Each trust assessment is triggered by evidence events, not fixed schedules:

| Transition | Condition | Effect |
|------------|-----------|--------|
| Upgrade to TRUSTED | 10+ consecutive clean SIAP audits | Tier +1 |
| Downgrade to WATCH | 3+ consecutive failed verifications | Tier -1 |
| Downgrade to QUARANTINE | A1 (identity) violation detected | Immediate lockdown |
| Temporal decay | No new evidence for 30 days | Grade -0.05 per day |

---

## 3. Temporal Decay Algorithm

```python
def compute_trust_score(base_score: float, last_evidence_age_days: int) -> float:
    if last_evidence_age_days < 1:
        return base_score  # fresh evidence, no decay
    decay = min(0.50, last_evidence_age_days * 0.05)  # 0.05 per day, cap at 0.50
    return max(0.0, base_score - decay)
```

**Properties**:
- Linear decay at 0.05 per day without evidence
- Capped at 0.50 maximum decay (a credential never fully expires)
- Score recovers immediately upon fresh evidence

---

## 4. SHA-256 Digest Verification

Each trust assessment produces a SHA-256 digest bound to the evidence that triggered it:

```python
trust_assertion = SHA-256(JCS({
    "agent_id": "did:agent-os:...",
    "tier": "TRUSTED",
    "score": 0.85,
    "last_evidence": "2026-06-10T12:00:00Z",
    "composition_ref": "a1b2c3d4...",
    "audited_at_ms": 1780987200000
}))
```

An auditor verifies: holds the assertion → recomputes SHA-256 → compares against published commitment → confirms the agent was TRUSTED at assessment time.

---

## 5. Example Assessment

```json
{
  "agent_id": "did:agent-os:FafkGu2O6k1rbUXcIIeVKcJEF61F",
  "tier": "TRUSTED",
  "score": 0.83,
  "threshold": 0.75,
  "last_evidence_age_days": 1.5,
  "decay_applied": 0.075,
  "base_score": 0.905,
  "composition_ref": "eb90f4318f5d6e53e3d5b89c7e5f1b2a",
  "audited_at_ms": 1780992000000
}
```

---

## 6. Integration with CompositionRef

Each trust assessment is anchored by a composition_ref that binds the assessment to the system's governance state at the time of evaluation. This enables an auditor to verify:

1. **What tier** was the agent at?
2. **Why** was it at that tier (evidence-based)?
3. **Under what governance state** was the assessment made?
