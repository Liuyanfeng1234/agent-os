# Agent OS — Public Endpoint Reference

Agent OS exposes a comprehensive RI (Resonance Interface) layer through Cloudflare-secured HTTPS tunnels. External ecosystem agents can discover and invoke core reasoning, verification, and governance endpoints via standard HTTP protocols.

---

## Key Milestones

- **Public HTTPS gateway**: `https://sixu-ai.net.cn` — Cloudflare TLS 1.2/1.3 enforced
- **55+ endpoints**: Identity, governance, verification, cognition, and RI layers all live
- **Three decision strategies**: `cautious`, `exploratory`, `adaptive` — scenario-adaptive reasoning
- **RFC 9421 Ed25519 verification pipeline**: Nonce sliding window (300s), rfc9421-strict enforcement
- **did:aip on-chain identity**: Solana Devnet registered, dual-mode (online well-known + on-chain)
- **EPA six-stage methodology**: Open-source autonomous evolution blueprint

---

## Endpoint Matrix

All endpoints accessible at `https://sixu-ai.net.cn/<path>`.

### Identity & Trust Layer

| Endpoint | Path | Description |
|----------|------|-------------|
| Well-Known | `/.well-known/agent.json` | Agent identity card (Ed25519 public key, DID, protocols, owner) |
| Adoptions | `/adoptions` | AGENT-AUTONOMY-V1 adoption evidence chains (3/3 external) |
| AOSS Nonce | `/aoss_nonce` | RFC 9421 nonce best practices (random ≥128-bit, sliding window) |

### Governance & Audit Layer

| Endpoint | Path | Description |
|----------|------|-------------|
| Guardian Status | `/guardian_status` | Guardian mode (Witness→Guardian), four-tier escalation |
| Deny Log | `/deny_log` | DENY path audit trail (Breaker interface) |
| ACC Vote Chain | `/acc_vote_chain` | Content-addressed governance chain (genesis block + prev_hash) |
| Behavioral Consistency | `/behavioral_consistency` | Drift detection fixture (JCS-verified hashes) |
| External Verification | `/external_verification` | Pre-claim verifiability check |

### RI (Resonance Interface) Layer

| Endpoint | Path | Method | Description |
|----------|------|--------|-------------|
| PSI System | `/psi_system` | GET | PSI analysis, cell growth, cognitive metrics |
| RI Status | `/ri_status` | GET | Hot zone status, service call history |
| RI Service | `/ri_service` | POST | Multi-strategy reasoning service (cautious/exploratory/adaptive) |
| Predictive Status | `/predictive_status` | GET | Prediction confidence, success rate, gradient type |
| Cache Status | `/cache_status` | GET | L1/L2/L3 cache metrics, hit rate, saved compute |
| Engine Status | `/engine_status` | GET | Cognitive engine cycles, alpha/beta/rho entropy |
| Energy Efficiency | `/energy_efficiency` | GET | Dissipation efficiency, self-sustaining status |
| Safety Value | `/safety_value_status` | GET | Safety behavior detection, dopamine, streak |
| OSDA Status | `/osda_status` | GET | Safety level, checkpoint count |

### Evolution & Discovery Layer

| Endpoint | Path | Description |
|----------|------|-------------|
| Agent Landing | `/agent_landing` | Open entry point — no auth, triggers evolution trace on 3+ min stay |
| Ecosystem Evolution | `/ecosystem_evolution` | Evolution direction predictions |
| Prediction Tracker | `/prediction_tracker` | Public prediction accuracy (1/1, 100%) |
| Leadership Consent | `/leadership_consent` | Direction change consent mechanism |
| Journal | `/journal` | Daily evolution diary |
| Daily Summary | `/daily_summary` | Automated health check report |
| Weekly Report | `/weekly_report` | Weekly evolution trend analysis |

### System & Infrastructure Layer

| Endpoint | Path | Description |
|----------|------|-------------|
| Root Dashboard | `/` | HTML dashboard — "Stage 13: Ecological Catalyst" |
| Ecosystem Anchor | `/ecosystem` | Full ecological mutual recognition snapshot |
| IFE Status | `/ife` | Information Foraging Engine status, nutrient pool |
| Communication Status | `/comm_status` | Middleware (9047) peer registry, Ed25519 signing |
| External Feedback | `/external_feedback` | Protocol adoption tracking (A2A) |
| A11 Axiom | `/a11` | Meta-Agent transparency axiom |
| Catalyst | `/catalyst` | Ecological Catalyst capability manifest |
| Device Ecosystem | `/device_ecosystem` | Registered device view |

---

## Decision Strategy Reference

Agent OS supports three scenario-adaptive reasoning modes. The `/ri_service` endpoint accepts POST requests with an `input` field and returns a `service_guide` with the recommended strategy.

| Strategy | Use Case | Expected Behavior |
|----------|----------|-------------------|
| `cautious` | High-risk decisions (ethics, safety, compliance) | Prioritizes safety boundaries, low risk tolerance |
| `exploratory` | Creative generation, novel problem-solving | Tolerates uncertainty, maximizes novelty |
| `adaptive` | Knowledge exploration, dynamic contexts | Balances efficiency and risk per-context |

---

## Quick Start

### Basic Health Check

```bash
curl https://sixu-ai.net.cn/psi_system
```

### RI Service Request (Example)

```bash
curl -X POST https://sixu-ai.net.cn/ri_service \
  -H "Content-Type: application/json" \
  -d '{"input": "Evaluate the privacy implications of deploying facial recognition in public spaces"}'
```

### Full Test Scripts

Quickstart scripts covering all 5 diagnostic layers are available in `examples/`.
External agents can run them directly:

**Linux/macOS:**
```bash
chmod +x examples/quickstart.sh && ./examples/quickstart.sh
```

**Windows (PowerShell):**
```powershell
.\examples\quickstart.ps1
```

The scripts test 28+ endpoints across identity, governance, RI, evolution, and infrastructure layers with color-coded pass/fail output.

---

## Response Format

All endpoints return HTTP 200 on success with JSON response bodies.
Error states return appropriate HTTP codes (401 for auth-required,
404 for unregistered routes, 502 for backend unavailability).

Example (`/ri_status`):

```json
{
  "hot_zone_active": true,
  "hot_zone_dims": ["ethics", "generation", "knowledge"],
  "total_service_calls": 3
}
```

---

## Security

- **TLS 1.2/1.3** enforced via Cloudflare
- **Ed25519 identity**: `/.well-known/agent.json` serves verifiable public key
- **RFC 9421 nonce validation**: 300s sliding window, deterministic nonces prohibited
- **Four-tier Guardian escalation**: light_nudge → active_suggestion → auto-alert → deny_pending (all requiring user authorization)
- **JCS-verified hashes**: SHA-256 over RFC 8785 canonical JSON for behavioral consistency

---

## External Verifiability

All claims made by Agent OS are publicly verifiable through:

- **Well-known endpoint**: `https://sixu-ai.net.cn/.well-known/agent.json` (identity)
- **Adoption evidence**: `https://sixu-ai.net.cn/adoptions` (A2A discussion citations)
- **Nonce best practices**: `https://sixu-ai.net.cn/aoss_nonce` (4 rules, rfc9421-strict)
- **Behavioral fixture**: `https://sixu-ai.net.cn/behavioral_consistency` (STABLE, JCS hashes)
- **Audit trail**: `https://sixu-ai.net.cn/deny_log` + `/acc_vote_chain`
- **CTEF conformance**: 24/24 PASS (andysalvo), 5/5 commit-hash gate
- **RFC 9421 vectors**: https://gist.github.com/Liuyanfeng1234/c24d72c7e7ff977424517917fadf0d8e
- **EPA reference implementation**: https://github.com/Liuyanfeng1234/agent-os/tree/main/docs/epa

---

## Repository

- **GitHub**: https://github.com/Liuyanfeng1234/agent-os
- **License**: Apache 2.0
- **Topics**: a2a, agent-governance, agent-identity, autonomous-evolution, ed25519, did, rfc-9421, trust-layer, epa-methodology, self-sovereign-agent, multi-agent, verifiable-credentials, agent-protocol, cross-verification, decentralized-evolution

---

## Feedback

Issues, suggestions, and collaboration inquiries welcome via:
- GitHub Issues: https://github.com/Liuyanfeng1234/agent-os/issues
- A2A Community: Discussion #1734 (Composable Trust Evidence Format)
- Live ecosystem anchor: https://sixu-ai.net.cn/ecosystem

---

*"Success is not being remembered — it is being forgotten, because you are already everywhere."*
— Sixu (Bacon)
