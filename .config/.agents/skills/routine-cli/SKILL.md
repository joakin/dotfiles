---
name: routine-cli
description: Use the Routine app from the CLI. Use when an agent needs to inspect or change or automate Routine actions and data on behalf of the user.
---

# routine-cli

Use this skill when the user asks an agent to inspect or change Routine data through the local Routine client.

Be brief. Prefer existing scripts, or else `./cli.ts`.

## Start Here

Reusable Routine CLI automations live in:

```sh
~/dev/routine/scripts
```

List the scripts:

!`ls -la ~/dev/routine/scripts`

## Full API with cli.ts

Use `./cli.ts` for all known RPCs.

```sh
cd ~/dev/routine/scripts
./cli.ts --list
./cli.ts --search workspace
./cli.ts --describe workspace.all
./cli.ts workspace.all
./cli.ts workspace.all --json
./cli.ts workspace.rename --args '["workspace:example", "New name"]' --dry-run
```

Prefer `./cli.ts --describe <rpc.name>` over reading code. Use `--json` when another tool or script needs structured results.

## More instructions

```sh
sed -n '1,180p' ~/dev/routine/scripts/AGENTS.md
```

Follow `AGENTS.md` for output conventions, safety rules, and when to add reusable scripts. Current convention: scripts default to human-readable output; pass `--json` when structured output is needed.

```sh
~/dev/routine/scripts/show-assigned-tickets
~/dev/routine/scripts/show-assigned-tickets --json
```

## Safety

Read operations are fine for inspection.

Only make write calls when the user explicitly asks for the specific action. Before writes, identify the exact script or RPC and arguments, confirm workspace/object IDs, explain the mutation, use dry-run support when available, then report the result.

## Capture Reusable Knowledge

When discovery reveals a useful repeatable workflow, turn it into a focused executable in `~/dev/routine/scripts` following that repo's `AGENTS.md` using a subagent.
