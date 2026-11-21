Review bundle: DeepSeek-V4 four layers, single-node 8x MI350X, three-step GRPO

Read maintainer-comment.txt for the proposed result comment; add the actual paired code PR links before posting.
summary.json contains the measured results and driver diagnosis. versions.json identifies both tested trees and patch bases.
RL-Kernel.patch and verl.patch contain the COMPLETE paired changes, not just the last None-gradient fix.
The patches were checked in reverse against the clean tested Git indexes; no code or Git index was modified while packaging.

To review from the tested bases, check out each recorded base commit in its respective repository and apply that repository's patch with git apply. The tested source commit IDs themselves are recorded for provenance; an unpublished local commit may not be fetchable from GitHub.

For rerun.sh, use a Linux user with Docker access, the matching built image, and the recorded source/model/data versions. Set GRPO_WORK, GRPO_CHECKPOINT and GRPO_DATA. GRPO_OUTPUT must not already exist. GRPO_IMAGE defaults to the measured local image ID; that image is not available by docker pull until it is published. Building prerequisites and gfx950 extension rebuilds are documented in RL-Kernel/docs/usage/dsv4-mi35x-validation.md.

The original independent verifier JSON is included unchanged. Its top-level eight-GPU scope is authoritative; nested per-replica scope strings inherit a legacy four-GPU label. The actual actor PP2/DP2 and two PP2 rollout topology is recorded in the top-level result and summary.

The 2,376 tokens per version are audit comparison observations, not newly generated training-token counts. Full raw FP32 tensors and policy snapshots are retained on the validation CI host and are not included in this compact bundle.
