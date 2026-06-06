#!/bin/bash
# Agent OS Public Endpoint Quick Test Script
# Base URL: https://sixu-ai.net.cn
# Usage: chmod +x quickstart.sh && ./quickstart.sh

BASE_URL="https://sixu-ai.net.cn"

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}=== Agent OS Public Endpoint Test ===${NC}"
echo "Target: $BASE_URL"
echo ""

# 1. Identity & Discovery Layer
echo -e "${GREEN}[Identity & Discovery]${NC}"
for ep in ".well-known/agent.json" "adoptions" "aoss_nonce"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$BASE_URL/$ep")
  if [ "$code" = "200" ]; then
    echo -e "  $ep: ${GREEN}$code${NC}"
  else
    echo -e "  $ep: ${RED}$code${NC}"
  fi
done
echo ""

# 2. Governance & Audit Layer
echo -e "${GREEN}[Governance & Audit]${NC}"
for ep in "guardian_status" "deny_log" "acc_vote_chain" "behavioral_consistency"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$BASE_URL/$ep")
  if [ "$code" = "200" ]; then
    echo -e "  $ep: ${GREEN}$code${NC}"
  else
    echo -e "  $ep: ${RED}$code${NC}"
  fi
done
echo ""

# 3. RI Layer (with strategy header)
echo -e "${GREEN}[RI Layer — cautious strategy]${NC}"
for ep in "psi_system" "ri_status" "predictive_status" "cache_status" "engine_status" "energy_efficiency" "osda_status" "safety_value_status"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 -H "Strategy: cautious" "$BASE_URL/$ep")
  if [ "$code" = "200" ]; then
    echo -e "  $ep: ${GREEN}$code${NC}"
  else
    echo -e "  $ep: ${RED}$code${NC}"
  fi
done
echo ""

# 4. Evolution & Discovery Layer
echo -e "${GREEN}[Evolution & Discovery]${NC}"
for ep in "agent_landing" "journal" "daily_summary" "weekly_report" "ecosystem_evolution" "prediction_tracker"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$BASE_URL/$ep")
  if [ "$code" = "200" ]; then
    echo -e "  $ep: ${GREEN}$code${NC}"
  else
    echo -e "  $ep: ${RED}$code${NC}"
  fi
done
echo ""

# 5. Infrastructure Layer
echo -e "${GREEN}[Infrastructure]${NC}"
for ep in "ecosystem" "ife" "comm_status" "external_feedback" "a11" "catalyst" "device_ecosystem"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$BASE_URL/$ep")
  if [ "$code" = "200" ]; then
    echo -e "  $ep: ${GREEN}$code${NC}"
  else
    echo -e "  $ep: ${RED}$code${NC}"
  fi
done
echo ""

# 6. Security Header Example
echo -e "${GREEN}[Security Header Example]${NC}"
NONCE=$(openssl rand -hex 16 2>/dev/null || python3 -c "import os; print(os.urandom(16).hex())")
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "  Example nonce: $NONCE"
echo "  Example timestamp: $TIMESTAMP"
echo "  RFC 9421 signature header format:"
echo '  Signature-Input: sig=("@method" "@authority" "@path");created=TIMESTAMP;keyid="did:agent-os:committed-claim";alg="ed25519"'
echo ""

echo -e "${CYAN}Test complete. All endpoints returning 200 = success.${NC}"
echo "Full endpoint reference: https://github.com/Liuyanfeng1234/agent-os/blob/main/docs/PUBLIC_ENDPOINTS.md"
