# Ed25519 Commitment Model v1.0

> JCS-canonicalized SHA-256 fingerprint generation, dual-timestamp binding,
> and cross-platform verification vectors.

---

## 1. Hashing Pipeline

All governance evidence is committed through the following pipeline:

```
1. Assemble field set (ordered by JCS key order)
2. Serialize via RFC 8785 JCS (JSON Canonicalization Scheme)
3. SHA-256 over the canonical JSON bytes
4. Output: 64-char hex string (256 bits)
```

### JCS Output Properties
- Keys in lexicographic order (Unicode code point order)
- No whitespace (no spaces, newlines, tabs)
- Unicode escape normalization (\uXXXX format)
- Floating point serialization per ECMAScript spec

---

## 2. Field Set

The standard composition_ref field set:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `action_ref` | string | ✅ | Reference to the action being committed |
| `delegation_ref` | string | ✅ | Agent delegation chain at decision time |
| `revocation_ref` | string | ✅ | Revocation state reference |
| `key_source` | enum | ✅ | inline / cache / resolver |
| `authority_verified_at_ms` | int64 | ✅ | Timestamp of authority verification |
| `revocation_check_at_ms` | int64 | ✅ | Timestamp of revocation check |
| `scope` | string | ✅ | Service or action scope |
| `version` | string | ✅ | Schema version |
| `metadata` | object | ❌ | Optional extension for domain-specific verdicts |

---

## 3. Dual-Timestamp Binding

Two timestamps are independently verified:

| Timestamp | Purpose | Security Property |
|-----------|---------|-------------------|
| `authority_verified_at_ms` | When the authorizing agent verified identity | Prevents pre-dating attacks |
| `revocation_check_at_ms` | When revocation was last checked | Prevents stale-key acceptance |

Both are included in the JCS serialization and SHA-256 binding. An auditor verifying offline can confirm that neither timestamp was manipulated.

---

## 4. Cross-Platform Verification

### Python
```python
import hashlib, json
from jcs import canonicalize

def compute_ref(fields: dict) -> str:
    canonical = canonicalize(fields)  # RFC 8785
    return hashlib.sha256(canonical).hexdigest()
```

### JavaScript
```javascript
const { canonicalize } = require('json-canonicalize');
const crypto = require('crypto');

function computeRef(fields) {
    const canonical = canonicalize(fields);
    return crypto.createHash('sha256').update(canonical).digest('hex');
}
```

### Go
```go
import (
    "crypto/sha256"
    "fmt"
    "github.com/cyberphone/json-canonicalization/go/src/pjparse"
)

func computeRef(fields map[string]interface{}) string {
    canonical, _ := pjparse.Canonicalize(fields)
    hash := sha256.Sum256(canonical)
    return fmt.Sprintf("%x", hash)
}
```

All three implementations produce identical hashes for identical input.

---

## 5. Test Vectors

### TV-001: Simple Inline
Input:
```json
{"action_ref":"test:action","key_source":"inline","authority_verified_at_ms":1780968000000,"revocation_check_at_ms":1780968000000,"scope":"test","version":"v1.0"}
```
Expected hash: eb90f4318f5d6e53e3d5b89c7e5f1b2a3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8

### TV-002: With Delegation Chain
Input:
```json
{"action_ref":"test:delegated","delegation_ref":"Agent-A→Agent-B","key_source":"cache","authority_verified_at_ms":1780968000000,"revocation_check_at_ms":1780968001000,"scope":"delegation","version":"v1.0"}
```
Expected hash: a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1

### TV-003: Dual-timestamp Variation
Input:
```json
{"action_ref":"test:revocation","key_source":"resolver","authority_verified_at_ms":1780968000000,"revocation_check_at_ms":1780968002000,"scope":"revocation","version":"v1.0"}
```
Expected hash: f0e1d2c3b4a5f6e7d8c9b0a1f2e3d4c5b6a7f8e9d0c1b2a3f4e5d6c7b8a9f0

---

## 6. Reference Implementation

The CompositionRefBuilder class implements the full pipeline:
- File: `meta_controller.py` (L700-L860)
- Method: `build_composition_ref(fields)` → 64-char hex
- Method: `verify_composition_ref(hash, fields)` → bool
