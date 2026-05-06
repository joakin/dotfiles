---
name: routine-cli
description: Use Routine from command-line agents through the native Routine controller REPL. Use when an agent needs to inspect or change the user's Routine data, call Routine RPCs, run graph queries, list organizations/workspaces/tables, or automate Routine on behalf of the user.
---

# routine-cli

Use this skill when the user asks an agent to inspect or change Routine data through the local Routine client.

Be brief. Prefer existing scripts over raw REPL discovery.

## Scripts First

Reusable Routine CLI automations live in:

```sh
~/dev/routine/scripts
```

Before using the raw REPL, list that folder and check whether an existing script already performs the requested action:

!`ls -la ~/dev/routine/scripts`

Prefer an existing script when it matches the request. Scripts should expose structured output for agents by default, usually JSON, and may also offer human-friendly output with a format flag.

```sh
~/dev/routine/scripts/show-assigned-tickets
~/dev/routine/scripts/show-assigned-tickets --format human
```

## Raw CLI

If no script exists, use the Routine CLI reference in [ROUTINE_CLI_COMMANDS.md](ROUTINE_CLI_COMMANDS.md).

Binary location:

```sh
~/dev/routine/scripts/routine-cli
```

If the symlink is missing, notify the user and stop.

The binary is a REPL. For agent automation, pipe commands into it so it exits on EOF.

Redirect stderr when parsing results because Routine logs go to stderr and command results print to stdout.

```sh
printf 'dev []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Expected stdout:

```text
true
```

## Safety

Read operations are fine for inspection.

Only make write calls when the user explicitly asks for the specific action. Before writes, identify the exact RPC and arguments, explain the intended mutation, confirm workspace/object IDs, run the command with stderr redirected, and report the result.

## Capture Reusable Knowledge

When raw REPL discovery reveals a useful repeatable workflow, ask a sub-agent to turn it into a reusable script in `~/dev/routine/scripts`.

Give the sub-agent the exact RPCs, graph queries, expected output contract, and file ownership. It must follow `~/dev/routine/scripts/AGENTS.md`, edit files directly, verify the script, and leave the result in the scripts git repo.
