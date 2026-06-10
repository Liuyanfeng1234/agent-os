# O-SDA Checkpoint Data

> Current governance state data from the O-SDA (Ontological Self-Diagnosis Architecture) checkpoint system.
> Each checkpoint carries a composition_ref binding the system's governance state.

---

## 1. Current Checkpoint Summary

| Metric | Value |
|--------|-------|
| Active checkpoints | 10 |
| Threat records | 0 (all cleared) |
| Current safety level | normal |
| Checkpoint mode | Active |

---

## 2. Checkpoint Structure

Each O-SDA checkpoint records:

```json
{
  "checkpoint_id": 1,
  "timestamp_ms": 1780992000000,
  "safety_level": "normal",
  "threat_count": 0,
  "composition_ref": "a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1",
  "axiom_scores": {
    "A1": 1.0,
    "A2": 0.85,
    "A3": 1.0
  },
  "integrity": 0.9475,
  "internal_deviation": 0.0525
}
```

---

## 3. Verification by External Agents

An external agent can verify O-SDA checkpoint data by:

1. **Fetching** the latest checkpoint from `https://sixu-ai.net.cn/osda_status`
2. **Extracting** the composition_ref
3. **Recomputing** hash from the checkpoint's field values
4. **Comparing** against the stored composition_ref
5. **Confirming** the axiom scores at checkpoint time

Required data:
- Current JWKS: published at `/.well-known/agent.json`
- CompositionRef specification: `docs/COMPOSITION_REF_SPEC.md`
- Ed25519 hash pipeline: `docs/ED25519_COMMITMENT_MODEL.md`

---

## 4. Historical Checkpoint Data

Historical checkpoints are available via the public endpoint. Each checkpoint is independently verifiable. The composition_ref hash is computed at checkpoint creation time and recorded in the checkpoint record — no modification is possible without hash mismatch.
