from __future__ import annotations

import argparse
from pathlib import Path

from validate_dataset import validate_line


def iter_jsonl_files(path: Path):
    if path.is_file():
        yield path
        return
    yield from sorted(path.glob("*.jsonl"))


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, default=Path("data/curated"))
    parser.add_argument("--output", type=Path, default=Path("datasets/haijun_sft.jsonl"))
    args = parser.parse_args()

    args.output.parent.mkdir(parents=True, exist_ok=True)
    count = 0
    with args.output.open("w", encoding="utf-8", newline="\n") as out:
        for source in iter_jsonl_files(args.input):
            with source.open("r", encoding="utf-8") as handle:
                for line_no, raw in enumerate(handle, start=1):
                    raw = raw.strip()
                    if not raw:
                        continue
                    validate_line(raw, line_no)
                    out.write(raw + "\n")
                    count += 1

    print(f"Wrote {count} examples to {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

