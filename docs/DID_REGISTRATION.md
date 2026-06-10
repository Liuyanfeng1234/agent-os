# did:agent-os Registration Process v1.0

> Protocol for self-registering an agent identity under the `did:agent-os` method.
> Deployed at: https://sixu-ai.net.cn/.well-known/agent.json

---

## 1. DID Method

`did:agent-os` is a lightweight DID method designed for self-evolving agent systems. It does not require a blockchain anchor — the DID document is served from the agent's well-known endpoint and verifiable through the published Ed25519 public key.

### DID Format

```
did:agent-os:{base64url(public_key)}
```

Example:
```
did:agent-os:FafkGu2O6k1rbUXcIIeVKcJEF61F
```

---

## 2. Registration Flow

### Step 1: Generate Ed25519 Key Pair

```bash
# Generate Ed25519 private key
openssl genpkey -algorithm ed25519 -out agent_private.pem

# Extract public key
openssl pkey -in agent_private.pem -pubout -out agent_public.pem

# Compute base64url-encoded public key for DID
python3 -c "
import base64
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import ed25519

with open('agent_public.pem', 'rb') as f:
    pub = serialization.load_pem_public_key(f.read())
    print(base64.urlsafe_b64encode(
        pub.public_bytes_raw()).decode().rstrip('='))
"
```

### Step 2: Create DID Document

```json
{
  "@context": "https://www.w3.org/ns/did/v1",
  "id": "did:agent-os:{base64url_pubkey}",
  "verificationMethod": [{
    "id": "did:agent-os:{base64url_pubkey}#key-1",
    "type": "Ed25519VerificationKey2020",
    "controller": "did:agent-os:{base64url_pubkey}",
    "publicKeyMultibase": "z{multibase_encoded_pubkey}"
  }],
  "authentication": ["did:agent-os:{base64url_pubkey}#key-1"],
  "assertionMethod": ["did:agent-os:{base64url_pubkey}#key-1"]
}
```

### Step 3: Issue First COMMITTED Claim

```python
# First COMMITTED Claim — proves the agent controls its identity
composition_ref = SHA-256(JCS({
    "action_ref": "AgentOS:REGISTER:genesis",
    "key_source": "inline",
    "authority_verified_at_ms": int(time.time() * 1000),
    "revocation_check_at_ms": int(time.time() * 1000),
    "scope": "identity:establishment"
}))
```

### Step 4: Serve at Well-Known Endpoint

Publish the DID document at `/.well-known/agent.json` on your HTTPS server.

---

## 3. Verification by External Agents

An external agent verifies a `did:agent-os` identity by:

1. **Fetching** the DID document from `https://{agent-host}/.well-known/agent.json`
2. **Extracting** the Ed25519 public key
3. **Checking** that the DID string matches `did:agent-os:{base64url(public_key)}`
4. **Verifying** a signature over a known message (e.g., the genesis COMMITTED Claim)

---

## 4. Production Reference

- Agent OS public key: `+FafkGu2O6k1rbUXcIIeVKcJEF61F/Z5GEsVI+5ZNZM=`
- Agent OS DID: `did:aip:5G5GerMXMug6DkVPhCZ4xmm7byf2jfYusYortw73Tc2X:agent-os`
- Well-known endpoint: `https://sixu-ai.net.cn/.well-known/agent.json`
- Identity anchor: `identity/agent-os.json` (GitHub)
