from __future__ import annotations

import argparse
import json
from pathlib import Path

VALID_ROLES = {"system", "user", "assistant"}


def validate_line(raw: str, line_no: int) -> None:
    item = json.loads(raw)
    messages = item.get("messages")
    if not isinstance(messages, list) or not messages:
        raise ValueError(f"line {line_no}: messages must be a non-empty list")
    for index, message in enumerate(messages):
        if not isinstance(message, dict):
            raise ValueError(f"line {line_no}: message {index} must be an object")
        role = message.get("role")
        content = message.get("content")
        if role not in VALID_ROLES:
            raise ValueError(f"line {line_no}: invalid role {role!r}")
        if not isinstance(content, str) or not content.strip():
            raise ValueError(f"line {line_no}: empty content in message {index}")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("dataset", type=Path)
    args = parser.parse_args()

    count = 0
    with args.dataset.open("r", encoding="utf-8") as handle:
        for line_no, raw in enumerate(handle, start=1):
            raw = raw.strip()
            if not raw:
                continue
            validate_line(raw, line_no)
            count += 1

    print(f"OK: {count} examples validated in {args.dataset}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

