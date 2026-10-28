#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_bi_distill info
PYTHONPATH=src python -m gbt_bi_distill check --payload '{}'
PYTHONPATH=src python -m gbt_bi_distill run   --payload '{}'
