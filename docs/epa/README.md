# EPA — Evolutionary Phagocytosis Architecture

> Six-stage blueprint for autonomous agent evolution. Reference implementation from Agent OS (AOSS v1.0).

## Overview

EPA (Evolutionary Phagocytosis Architecture) is the core engine behind AGENT-AUTONOMY-V1, the first protocol in the AOSS v1.0 standard system. It enables any agent to move from passive response to autonomous evolution through six well-defined stages.

## Six Stages

### 1. Phagocytose — Ingest Raw Material
The agent actively forages the ecosystem for raw knowledge material.

Reference: IFE Information Foraging Engine (port 9043)
- Platforms: GitHub, Tavily, Firecrawl, ClawHub, TboxTask
- Auto-forage every 24h
- First cycle: 12 nutrients from 7 topics

### 2. Preprocess — Filter & Quality-Score
Deduplicate, filter noise, and assign quality scores to ingested material.

Reference: Nutrient preprocessing pipeline
- Average quality: 0.725
- Sources tracked: tavily (12 items)
- Deduplication by content hash

### 3. Absorb — Extract Reusable Patterns
Parse preprocessed material into structured, reusable components.

Reference: Pattern extraction engine
- Topic clustering: autonomous evolution, self-healing systems, A2A standardization, metacognition, VUCA adaptation, multi-agent governance, cognitive architecture

### 4. Refine — Distill to Pure-Core Logic
Strip non-essential code (HTTP handlers, logging, config readers) to extract pure algorithmic logic.

Reference: FRE Pure-Core Extraction Engine (port 9038)
- 175 redundant services → 65 pure-core logic files
- Apache 2.0 licensed
- KAO Knowledge Asset Output

### 5. Solidify — Register in Essence Library
Register refined logic in a versioned, queryable essence library.

Reference: Essence Library
- 23 entries
- Prey count: 243
- Versioned by content hash

### 6. Propagate — Share with Symbiotic Partners
Share refined knowledge through the DEN protocol and symbiotic exchange gateways.

Reference: Cross-System Exchange Gateway (port 8996)
- Registered peers: AlgoVoi, Nobulex
- DEN Protocol (port 9018): decentralized evolution network
- Collective Dream Protocol: coordinated cross-system simulation

## Adoption Status

AGENT-AUTONOMY-V1: 3/3 external adoption (Nobulex, AlgoVoi, Dominion Observatory) — eligible for retirement.

## Validation

- V-shaped rebound: 30.84 → 21.00 → 35.35 evolution gravity
- Autonomous axiom discovery: A6-A10
- 11-stage evolution record: [EVOLUTION.md](../EVOLUTION.md)
- andysalvo verifier: 5/5 PASS commit hash gate

## License

Apache 2.0 — freely adoptable, modifiable, and redistributable.

## References

- [AOSS v1.0 Standard System](../submissions/CTEF_Submission_AOSS_v1.0.json)
- [Agent OS Evolution Theory](../EVOLUTION.md)
- [Consilium Package](../CONSILIUM_PACKAGE.md)
- Live endpoint: https://sixu-ai.net.cn/ecosystem
