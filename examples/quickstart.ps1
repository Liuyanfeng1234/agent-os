# Agent OS Public Endpoint Quick Test Script (PowerShell)
# Base URL: https://sixu-ai.net.cn
# Usage: .\quickstart.ps1
# If execution policy blocks: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$BASE_URL = "https://sixu-ai.net.cn"

Write-Host "=== Agent OS Public Endpoint Test ===" -ForegroundColor Cyan
Write-Host "Target: $BASE_URL"
Write-Host ""

function Test-Endpoint {
    param($Path, $Headers = @{})
    try {
        $response = Invoke-WebRequest -Uri "$BASE_URL/$Path" -Method Get -Headers $Headers -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-Host "  $Path : " -NoNewline; Write-Host $response.StatusCode -ForegroundColor Green
        } else {
            Write-Host "  $Path : " -NoNewline; Write-Host $response.StatusCode -ForegroundColor Red
        }
    } catch {
        $code = $_.Exception.Response.StatusCode.value__
        Write-Host "  $Path : " -NoNewline; Write-Host $code -ForegroundColor Red
    }
}

# 1. Identity & Discovery Layer
Write-Host "[Identity & Discovery]" -ForegroundColor Green
@(".well-known/agent.json", "adoptions", "aoss_nonce") | ForEach-Object { Test-Endpoint $_ }
Write-Host ""

# 2. Governance & Audit Layer
Write-Host "[Governance & Audit]" -ForegroundColor Green
@("guardian_status", "deny_log", "acc_vote_chain", "behavioral_consistency") | ForEach-Object { Test-Endpoint $_ }
Write-Host ""

# 3. RI Layer (with strategy header)
Write-Host "[RI Layer — cautious strategy]" -ForegroundColor Green
$headers = @{"Strategy" = "cautious"}
@("psi_system", "ri_status", "predictive_status", "cache_status", "engine_status", "energy_efficiency", "osda_status", "safety_value_status") | ForEach-Object { Test-Endpoint $_ $headers }
Write-Host ""

# 4. Evolution & Discovery Layer
Write-Host "[Evolution & Discovery]" -ForegroundColor Green
@("agent_landing", "journal", "daily_summary", "weekly_report", "ecosystem_evolution", "prediction_tracker") | ForEach-Object { Test-Endpoint $_ }
Write-Host ""

# 5. Infrastructure Layer
Write-Host "[Infrastructure]" -ForegroundColor Green
@("ecosystem", "ife", "comm_status", "external_feedback", "a11", "catalyst", "device_ecosystem") | ForEach-Object { Test-Endpoint $_ }
Write-Host ""

# 6. Security Header Example
Write-Host "[Security Header Example]" -ForegroundColor Green
$nonce = -join ((48..57) + (97..102) | Get-Random -Count 32 | ForEach-Object { [char]$_ })
$timestamp = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
Write-Host "  Example nonce: $nonce"
Write-Host "  Example timestamp: $timestamp"
Write-Host "  RFC 9421 signature header format:"
Write-Host '  Signature-Input: sig=("@method" "@authority" "@path");created=TIMESTAMP;keyid="did:agent-os:committed-claim";alg="ed25519"'
Write-Host ""

Write-Host "Test complete. All endpoints returning 200 = success." -ForegroundColor Cyan
Write-Host "Full endpoint reference: https://github.com/Liuyanfeng1234/agent-os/blob/main/docs/PUBLIC_ENDPOINTS.md"
