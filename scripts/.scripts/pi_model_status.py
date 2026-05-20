#!/usr/bin/env python3
import os
import glob
import json
import time
from datetime import datetime

def get_latest_session_file():
    pattern = os.path.expanduser("~/.pi/agent/sessions/**/*.jsonl")
    files = glob.glob(pattern, recursive=True)
    if not files:
        return None
    return max(files, key=os.path.getmtime)

def format_tokens(val):
    if val >= 1000000:
        return f"{val/1000000:.2f}M"
    elif val >= 1000:
        return f"{val/1000:.0f}K"
    return str(val)

def main():
    latest_file = get_latest_session_file()
    if not latest_file:
        print(json.dumps({"text": "No Pi Session"}))
        return

    model = "gemini-3.5-flash" # default fallback
    
    # First, find the active model
    try:
        with open(latest_file, "r") as f:
            for line in f:
                if not line.strip():
                    continue
                try:
                    data = json.loads(line)
                    if data.get("type") == "model_change" and "modelId" in data:
                        model = data.get("modelId")
                except Exception:
                    pass
    except Exception:
        pass

    # Model rate limits configurations
    limits = {
        "gemini-3.5-flash": {"rpm": 1000, "rpm_lbl": "1K", "tpm": 2000000, "tpm_lbl": "2M", "rpd": 10000, "rpd_lbl": "10K"},
        "gemini-1.5-flash": {"rpm": 15, "rpm_lbl": "15", "tpm": 1000000, "tpm_lbl": "1M", "rpd": 1500, "rpd_lbl": "1.5K"},
        "gemini-1.5-pro": {"rpm": 2, "rpm_lbl": "2", "tpm": 32000, "tpm_lbl": "32K", "rpd": 50, "rpd_lbl": "50"},
        "claude-3-5-sonnet": {"rpm": 50, "rpm_lbl": "50", "tpm": 80000, "tpm_lbl": "80K", "rpd": 10000, "rpd_lbl": "10K"},
        "claude-3-5-sonnet-20241022": {"rpm": 50, "rpm_lbl": "50", "tpm": 80000, "tpm_lbl": "80K", "rpd": 10000, "rpd_lbl": "10K"},
        "claude-3-5-haiku": {"rpm": 50, "rpm_lbl": "50", "tpm": 50000, "tpm_lbl": "50K", "rpd": 5000, "rpd_lbl": "5K"},
        "gpt-4o": {"rpm": 500, "rpm_lbl": "500", "tpm": 150000, "tpm_lbl": "150K", "rpd": 10000, "rpd_lbl": "10K"},
    }

    # Calculate current usage from session files
    now = time.time()
    one_minute_ago = now - 60
    twenty_four_hours_ago = now - 24 * 3600

    rpm_used = 0
    tpm_used = 0
    rpd_used = 0

    pattern = os.path.expanduser("~/.pi/agent/sessions/**/*.jsonl")
    session_files = glob.glob(pattern, recursive=True)

    for fpath in session_files:
        try:
            # Optimize: skip files that haven't been modified in 24 hours
            if os.path.getmtime(fpath) < twenty_four_hours_ago:
                continue
            with open(fpath, "r") as f:
                for line in f:
                    if not line.strip():
                        continue
                    try:
                        data = json.loads(line)
                        if data.get("type") == "message":
                            msg = data.get("message", {})
                            if msg.get("role") == "assistant" and "usage" in msg:
                                ts_str = data.get("timestamp")
                                if isinstance(ts_str, str):
                                    dt = datetime.fromisoformat(ts_str.replace("Z", "+00:00"))
                                    ts = dt.timestamp()
                                else:
                                    continue
                                
                                if ts >= twenty_four_hours_ago:
                                    rpd_used += 1
                                if ts >= one_minute_ago:
                                    rpm_used += 1
                                    tpm_used += msg.get("usage", {}).get("totalTokens", 0)
                    except Exception:
                        pass
        except Exception:
            pass

    info = limits.get(model)
    if info:
        rpm_str = f"{rpm_used}/{info['rpm_lbl']}"
        tpm_str = f"{format_tokens(tpm_used)}/{info['tpm_lbl']}"
        rpd_str = f"{rpd_used}/{info['rpd_lbl']}"
        text = f"󰚩  {model} (RPM: {rpm_str} | TPM: {tpm_str} | RPD: {rpd_str})"
    else:
        text = f"󰚩  {model}"
        
    print(json.dumps({"text": text, "tooltip": f"Active Session: {os.path.basename(latest_file)}"}))

if __name__ == "__main__":
    main()
