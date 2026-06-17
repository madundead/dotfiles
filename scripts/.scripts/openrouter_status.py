#!/usr/bin/env python3
import os
import glob
import json
import time
import urllib.request
from datetime import datetime


def get_latest_session_file():
    pattern = os.path.expanduser("~/.pi/agent/sessions/**/*.jsonl")
    files = glob.glob(pattern, recursive=True)
    if not files:
        return None
    return max(files, key=os.path.getmtime)


def pretty_model_name(model_id):
    if not model_id or model_id == "unknown":
        return "?"
    if "/" in model_id:
        return model_id.split("/")[-1]
    return model_id


def format_usd(val):
    if val >= 1:
        return f"${val:.2f}"
    elif val >= 0.01:
        return f"${val:.3f}"
    else:
        cents = round(val * 100, 1)
        return f"{cents}c"


def format_tokens(val):
    if val >= 1000000:
        return f"{val/1000000:.1f}M"
    elif val >= 1000:
        return f"{val/1000:.0f}K"
    return str(val)


def fetch_openrouter_credits():
    """Query OpenRouter /v1/credits for account balance."""
    api_key = os.environ.get("OPENROUTER_API_KEY") or os.environ.get("OPENROUTER_KEY")
    if not api_key:
        key_file = os.path.expanduser("~/.config/openrouter/key")
        if os.path.exists(key_file):
            with open(key_file) as f:
                api_key = f.read().strip()
    if not api_key:
        return None

    req = urllib.request.Request(
        "https://openrouter.ai/api/v1/credits",
        headers={"Authorization": f"Bearer {api_key}"},
    )
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read())
        return data.get("data")
    except Exception:
        return None


def get_current_model():
    settings_path = os.path.expanduser("~/.pi/agent/settings.json")
    default_model = None
    try:
        if os.path.exists(settings_path):
            with open(settings_path) as f:
                settings = json.load(f)
            provider = settings.get("defaultProvider", "")
            model = settings.get("defaultModel", "")
            if provider and model:
                default_model = model
    except Exception:
        pass

    latest = get_latest_session_file()
    model = default_model
    if latest:
        try:
            with open(latest) as f:
                for line in f:
                    if not line.strip():
                        continue
                    data = json.loads(line)
                    if data.get("type") == "model_change" and "modelId" in data:
                        model = data.get("modelId")
                        break
        except Exception:
            pass

    return model or "unknown"


def count_pi_usage():
    """Count today's requests and tokens from Pi session files."""
    now = time.time()
    twenty_four_hours_ago = now - 24 * 3600
    rpd = 0
    tpd = 0

    pattern = os.path.expanduser("~/.pi/agent/sessions/**/*.jsonl")
    for fpath in glob.glob(pattern, recursive=True):
        try:
            if os.path.getmtime(fpath) < twenty_four_hours_ago:
                continue
            with open(fpath) as f:
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
                                tokens = msg.get("usage", {}).get("totalTokens", 0)
                                if ts >= twenty_four_hours_ago:
                                    rpd += 1
                                    tpd += tokens
                    except Exception:
                        pass
        except Exception:
            pass

    return rpd, tpd


def main():
    or_data = fetch_openrouter_credits()
    model = get_current_model()
    short = pretty_model_name(model)
    reqs, tokens = count_pi_usage()

    if or_data:
        total_credits = or_data.get("total_credits", 0)
        total_usage = or_data.get("total_usage", 0)
        remaining = total_credits - total_usage
        credits_display = format_usd(remaining)
    else:
        credits_display = "?"

    # Build display: credits | model | reqs/tokens
    stats = f"{reqs}r \u00b7 {format_tokens(tokens)}t" if reqs > 0 else ""
    text = f"{credits_display} | {short} | {stats}" if stats else f"{credits_display} | {short}"

    # Tooltip
    tooltip_lines = [f"Model: {model}"]
    if or_data:
        tooltip_lines.append(
            f"OR credits: {format_usd(remaining)} left of {format_usd(total_credits)}"
        )
    tooltip_lines.append(f"Pi today: {reqs} requests, {format_tokens(tokens)} tokens")

    print(json.dumps({"text": text, "tooltip": "\n".join(tooltip_lines), "alt": "openrouter"}))


if __name__ == "__main__":
    main()