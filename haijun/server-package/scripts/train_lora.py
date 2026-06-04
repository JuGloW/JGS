from __future__ import annotations

import argparse
from pathlib import Path

import torch
import yaml
from datasets import load_dataset
from peft import LoraConfig
from transformers import AutoModelForCausalLM, AutoTokenizer, BitsAndBytesConfig
from trl import SFTConfig, SFTTrainer


def load_config(path: Path) -> dict:
    with path.open("r", encoding="utf-8") as handle:
        return yaml.safe_load(handle)


def format_messages(example: dict) -> str:
    messages = example["messages"]
    parts = []
    for message in messages:
        role = message["role"].strip()
        content = message["content"].strip()
        parts.append(f"<|{role}|>\n{content}")
    return "\n".join(parts) + "\n<|end|>"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", type=Path, default=Path("configs/haijun.yaml"))
    parser.add_argument("--model-id", required=True)
    args = parser.parse_args()

    cfg = load_config(args.config)
    train_cfg = cfg["training"]
    lora_cfg = cfg["lora"]

    dataset = load_dataset("json", data_files=str(train_cfg["dataset_path"]), split="train")

    tokenizer = AutoTokenizer.from_pretrained(args.model_id, use_fast=True)
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token

    quantization_config = BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_quant_type="nf4",
        bnb_4bit_compute_dtype=torch.bfloat16,
        bnb_4bit_use_double_quant=True,
    )
    model = AutoModelForCausalLM.from_pretrained(
        args.model_id,
        device_map="auto",
        quantization_config=quantization_config,
        torch_dtype=torch.bfloat16,
    )

    peft_config = LoraConfig(
        r=lora_cfg["r"],
        lora_alpha=lora_cfg["alpha"],
        lora_dropout=lora_cfg["dropout"],
        target_modules=lora_cfg["target_modules"],
        bias="none",
        task_type="CAUSAL_LM",
    )

    sft_config = SFTConfig(
        output_dir=train_cfg["output_dir"],
        max_seq_length=train_cfg["max_seq_length"],
        num_train_epochs=train_cfg["num_train_epochs"],
        learning_rate=train_cfg["learning_rate"],
        warmup_ratio=train_cfg["warmup_ratio"],
        per_device_train_batch_size=train_cfg["per_device_train_batch_size"],
        gradient_accumulation_steps=train_cfg["gradient_accumulation_steps"],
        save_steps=train_cfg["save_steps"],
        logging_steps=train_cfg["logging_steps"],
        seed=train_cfg["seed"],
        bf16=True,
        packing=False,
    )

    trainer = SFTTrainer(
        model=model,
        args=sft_config,
        train_dataset=dataset,
        peft_config=peft_config,
        formatting_func=format_messages,
        processing_class=tokenizer,
    )
    trainer.train()
    trainer.save_model()
    tokenizer.save_pretrained(train_cfg["output_dir"])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

