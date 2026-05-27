#!/usr/bin/env python3
"""Agent OS Credential Lifecycle Manager — v85/payment_matrix"""
import json, time, hashlib

class CredentialLifecycleManager:
    def __init__(self):
        self.credentials = {}
    def issue_credential(self, agent_did, capabilities):
        cred = {"id": hashlib.sha256(f"{agent_did}:{time.time()}".encode()).hexdigest()[:16], "agent_did": agent_did, "issued_at": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()), "status": "active"}
        self.credentials[cred["id"]] = cred
        return cred
    def verify_credential(self, cred_id):
        cred = self.credentials.get(cred_id)
        return {"valid": cred is not None and cred["status"] == "active", "credential": cred}

engine = CredentialLifecycleManager()
