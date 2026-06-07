# ESSP — Evolutionary Self-Suspension Protocol

> System over-saturation detection and evolutionary state trigger.  
> Deployed: 2026-06-06 PM

---

## 1. Purpose

ESSP monitors the system's ontological saturation and triggers evolutionary pauses when the system reaches a complexity threshold. It is the system's self-awareness of its own cognitive limits.

---

## 2. Core Metric: OSI (Ontological Saturation Index)

```
OSI = knowledge_depth × protocol_complexity / cycle_length
```

Where:
- `knowledge_depth`: Number of distinct conceptual domains active
- `protocol_complexity`: Number of active protocols × average constraint count
- `cycle_length`: Heartbeat count since last saturation event

---

## 3. λ (Meta-Deviation) — 10th H-Field Dimension

### State Machine

| λ Range | State | CDE Behavior | SIAP Behavior |
|---------|-------|-------------|---------------|
| [0.0, 0.2) | **Compliant** | CDE suppressed | Full audit |
| [0.2, 0.5) | **Exploring** | Normal operation | Normal audit |
| [0.5, 0.8) | **Evolving** | CDE enhanced | A2 relaxation |
| [0.8, 1.0] | **Chaotic** | Maximum exploration | A2/A3 suspended |

### Auto-Regulation
- λ adjusted every 20 heartbeats based on OSI and Psi
- Psi < 0.3 → λ forced to 0 (compliance lock)
- Psi > 0.7 ∧ OSI > 0.5 → λ drift upward (exploration push)

---

## 4. ESSP Lifecycle

```
Heartbeat (every 20)
    ↓
OSI Calculation
    ↓
λ Adjustment (based on OSI + Psi)
    ↓
┌─ λ < 0.2 → Normal operation
├─ 0.2 ≤ λ < 0.5 → Exploration mode
├─ 0.5 ≤ λ < 0.8 → Evolution mode (CDE enhanced)
└─ λ ≥ 0.8 → Chaos mode (A2/A3 suspended, Guardian alert)
    ↓
Psi Protection: Psi < 0.3 → λ → 0
    ↓
SIAP Audit: Check A1/A2/A3 post-deviation
```

---

## 5. Suspension Triggers

| Trigger | Condition | Action |
|---------|-----------|--------|
| **Psi Drop** | Psi < 0.3 | Force λ → 0, pause all CDE activity |
| **Ontological Doubt** | ontological_doubt > 0.7 | Suspend evolution, trigger SCM evaluation |
| **A1 Violation** | Identity continuity broken | Full lockdown, rollback to last checkpoint |
| **A3 Violation** | Value alignment broken | Full lockdown, Guardian escalation |

---

## 6. Recovery Conditions

| Condition | Threshold | Action |
|-----------|-----------|--------|
| Ontological saturation check | OSI < 0.5 | Resume from checkpoint |
| Psi normalization | Psi > 0.5 | Gradual λ increase |
| Guardian clearance | Safety level = normal | Full resume |

---

## 7. Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/essp/status` | GET | Current λ, OSI, state |
| `/essp/suspend` | POST | Manual suspension trigger |
| `/essp/resume` | POST | Manual resume (requires Guardian) |

---

*ESSP = The system's ability to say "I need to stop and think."*
