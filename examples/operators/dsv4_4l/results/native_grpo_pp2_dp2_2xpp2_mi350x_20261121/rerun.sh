#!/usr/bin/env bash
set -euo pipefail
: "${GRPO_WORK:?Set the workspace containing src/RL-Kernel and cache}"
: "${GRPO_CHECKPOINT:?Set the delivered four-layer checkpoint directory}"
: "${GRPO_DATA:?Set the delivered data directory including checkpoint-inventory.json}"
GRPO_IMAGE="${GRPO_IMAGE:-sha256:a2868c2822cabcbdbf40b3489002eb1edc9d524b6e5be9e0d77e9c8ec8618dff}"
GRPO_OUTPUT="${GRPO_OUTPUT:-$GRPO_WORK/runs/grpo8-review-$(date +%Y%m%d-%H%M%S)}"
docker image inspect "$GRPO_IMAGE" >/dev/null
python3 "$GRPO_WORK/src/RL-Kernel/examples/operators/dsv4_4l/run_grpo.py" \
  "$GRPO_IMAGE" "$GRPO_CHECKPOINT" "$GRPO_DATA" "$GRPO_OUTPUT" "$GRPO_WORK/cache" \
  --num-gpus 8 --numa-interleave --audit-response-length 16 \
  --audit-prompts-file "$GRPO_DATA/extended-audit-prompts.json" --stress-final-repeats 0
docker run --rm --network=none --cpus=4 -e OMP_NUM_THREADS=4 \
  -v "$GRPO_OUTPUT:/outputs" -v "$GRPO_DATA:/data:ro" \
  --entrypoint /opt/dsv4-venv/bin/python "$GRPO_IMAGE" \
  /opt/dsv4/RL-Kernel/examples/operators/dsv4_4l/verify_grpo.py \
  /outputs/policy-sync --inventory /data/checkpoint-inventory.json
