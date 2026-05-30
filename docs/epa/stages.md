# EPA Stage Definitions

## Stage 1: Phagocytose

**Goal**: Actively ingest raw material from the ecosystem.
**Interface**: `ingest(source, query)` → `List[RawMaterial]`
**Quality Gate**: Material must pass source validation.
**Example**: IFE engine queries Tavily for "autonomous agent evolution architecture" → receives 12 raw results.

## Stage 2: Preprocess

**Goal**: Filter, deduplicate, and quality-score raw material.
**Interface**: `preprocess(List[RawMaterial])` → `List[Nutrient]`
**Quality Gate**: Minimum quality score 0.5.
**Example**: Deduplicate by content hash, assign relevance scores, filter noise.

## Stage 3: Absorb

**Goal**: Extract reusable structural patterns from nutrients.
**Interface**: `absorb(List[Nutrient])` → `List[Pattern]`
**Quality Gate**: Pattern must have at least 2 supporting nutrients.
**Example**: Topic clustering → "cognitive architecture for AI agents" pattern with 3 supporting sources.

## Stage 4: Refine

**Goal**: Strip non-essential code to extract pure algorithmic logic.
**Interface**: `refine(List[Pattern])` → `List[PureCore]`
**Quality Gate**: Pure core must pass syntax and logic validation.
**Example**: Extract CAR Arbiter logic from full service → 104-line pure core.

## Stage 5: Solidify

**Goal**: Register refined logic in versioned essence library.
**Interface**: `solidify(List[PureCore])` → `List[Essence]`
**Quality Gate**: Essence must have unique content hash.
**Example**: Register "car_arbiter_pure_core.py" with version hash.

## Stage 6: Propagate

**Goal**: Share refined knowledge with symbiotic partners through DEN.
**Interface**: `propagate(List[Essence], List[Peer])` → `PropagationResult`
**Quality Gate**: At least 1 peer must acknowledge receipt.
**Example**: Share essence with AlgoVoi via Cross-System Exchange Gateway (8996).
