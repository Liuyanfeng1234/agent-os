# CompositionRef Field Definition v1.1

> Full field specification, metadata extension mechanism, and test vectors.
> Aligned with argentum-core composition-ref-v1.0 (giskard09/argentum-core#10).

---

## 1. Field Set

| Field | Type | Required | JCS Order | Description |
|-------|------|----------|-----------|-------------|
| `action_ref` | string | ✅ | 1 | What action was committed |
| `delegation_ref` | string | ✅ | 2 | Agent delegation chain at decision time |
| `revocation_ref` | string | ✅ | 3 | Revocation state reference |
| `key_source` | enum | ✅ | 4 | inline / cache / resolver |
| `authority_verified_at_ms` | int64 | ✅ | 5 | When authority was verified |
| `revocation_check_at_ms` | int64 | ✅ | 6 | When revocation was last checked |
| `scope` | string | ✅ | 7 | Service or action scope |
| `version` | string | ✅ | 8 | Schema version |
| `metadata` | object | ❌ | 9 | Domain-specific extensions |

---

## 2. Hash Computation

```
composition_ref = SHA-256(JCS(all_required_fields))
```

- Serialization: RFC 8785 JCS (JSON Canonicalization Scheme)
- Hash: SHA-256 full (64 hex chars / 256 bits)
- Verification: auditor recomputes from field values and compares

---

## 3. Metadata Extension

The `metadata` field is an optional extension for domain-specific verdicts.
It does not affect the JCS hash of the core fields — metadata is included
in the serialization but the core schema remains stable.

Example:
```json
{
  "action_ref": "ClinicalReview:APPROVE:claim-0x1234",
  "key_source": "resolver",
  "authority_verified_at_ms": 1780992000000,
  "revocation_check_at_ms": 1780992000000,
  "scope": "pharma_compliance",
  "version": "v1.1",
  "metadata": {
    "domain_verdicts": [{
      "claim_id": "CLM-001",
      "verdict": "verified",
      "standard": "EU_GMP_Annex11",
      "reviewer": "clinical_review_agent"
    }]
  }
}
```

---

## 4. Test Vectors

Seven test vectors covering all key scenarios:

| Vector | Scenario | Key Source | Expected |
|--------|----------|-----------|----------|
| TV-001 | Valid inline | inline | pass |
| TV-002 | Valid cache | cache | pass |
| TV-003 | Valid resolver | resolver | pass |
| TV-004 | HTTP tamper | inline→cache (tampered) | **fail** |
| TV-005 | Stress (10KB metadata) | resolver | pass |
| TV-006 | JCS canonicalization | varied key order | identical hash |
| TV-007 | Invariant 5 (revocation) | different revocation_ref | different hash |

---

## 5. Implementation

- **Build**: `SHA-256(JCS(fields)).hexdigest()`
- **Verify**: recompute hash from received fields, compare against stored hash
- **Offline invariant**: verifier needs only the composition_ref, the field values, and the published JWKS — no service dependency

---

## 6. Related Documents

- argentum-core#10: key_source field definition (SSRF-constrained)
- A2A#1918: production governance state tracking data (15 rounds of evidence)
- docs/DID_REGISTRATION.md: agent identity establishment
- docs/ED25519_COMMITMENT_MODEL.md: hashing pipeline and cross-platform vectors
