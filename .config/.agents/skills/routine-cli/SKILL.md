---

## name: routine-cli

description: Use Routine from command-line agents through the native Routine controller REPL. Use when an agent needs to inspect or change the user's Routine data, call Routine RPCs, run graph queries, list organizations/workspaces/tables, or automate Routine on behalf of the user.

# Routine CLI

## Purpose

Use the Routine native client to interact with Routine programmatically from external agents. The client starts a local Routine controller, authenticates as the current user using cached local Routine auth state, and accepts REPL commands on stdin.

## Scripts First

Reusable Routine CLI automations live in:

```bash
~/dev/routine/scripts
```

Before using the raw REPL directly, list that folder and check whether an existing script already performs the requested action:

```bash
ls -la ~/dev/routine/scripts
```

Prefer an existing script when it matches the user's request. Scripts should expose structured output for agents/LLMs by default, usually JSON, and may also offer human-friendly output with a format flag. For example:

```bash
~/dev/routine/scripts/show-assigned-tickets
~/dev/routine/scripts/show-assigned-tickets --format human
```

If no script exists for the requested action, use the raw Routine CLI instructions below to discover and perform the action. Once the action is understood, use a sub-agent to capture that knowledge as a reusable script in `~/dev/routine/scripts` so future agents do not need to rediscover the same RPCs or graph queries.

Give it the exact RPCs, graph queries, expected output contract, and file ownership for a new script in `~/dev/routine/scripts`. Follow `~/dev/routine/scripts/AGENTS.md`, edit files directly, verify the script, and leave the result in the scripts git repo. Notify the user about the results of this work.

## Binary

Binary location:

```bash
~/dev/routine/scripts/routine-cli
```

If the symlink is missing, notify the user and stop.

The binary is a REPL. Do not launch it with an open interactive stdin unless the user wants an interactive session. For agent automation, pipe commands into it so it exits on EOF.

## Permissions

Run outside restrictive sandboxes when possible. The client reads and writes Routine's local saved auth/state, such as files under the user's Library/Saved Application State on macOS. If sandboxed, it may fail to reuse auth and queue RPCs before login.

Redirect stderr when parsing results. Routine logs go to stderr; command results are printed to stdout.

```bash
printf 'dev []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Expected stdout:

```text
true
```

## REPL Command Format

RPC call:

```text
<rpc.name> <json-array-args>
```

Examples:

```bash
printf 'workspace.all []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
printf 'organization.all []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
printf 'workspace.get ["workspace:SMTbNfiPLsH79GsSzU75a"]\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Graph query:

```text
?<query>
```

Graph query typecheck:

```text
??<query>
```

Graph command:

```text
!<command>
```

Login helper, if auth is missing:

```text
:login help
```

## Finding RPC Calls

Use the generated TypeScript RPC surface as the quickest index:

```bash
~/dev/routine/front/controller/controller-rpc.d.ts
```

Important sections:

- `organization`: `all`, `get`, `personal`, `workspaces.all`, member operations.
- `workspace`: `all`, `get`, `default`, `personalId`, member operations.
- `graph.database`: `list`, `listPersonal`, `get`, `defaultTypes.get`.
- `task`, `page`, `event`, `calendar`, `people`: user-facing Routine object APIs.

The source declarations live in:

```bash
~/dev/routine/front/api/controller/lib/rpcs/
```

Look for `call`, `call_async`, and `call_reactive`. From an external caller they all behave as commands that eventually print a result; in generated TypeScript they are exposed as promises. `call_reactive` may return a releasable reactive reference in the frontend, but the REPL prints the current value.

## Useful Read-Only Calls

List organizations:

```bash
printf 'organization.all []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Get an organization:

```bash
printf 'organization.get ["org:SMTbNfiPLsH79GsSzU75a"]\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

List all workspaces:

```bash
printf 'workspace.all []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Get a workspace:

```bash
printf 'workspace.get ["workspace:SMTbNfiPLsH79GsSzU75a"]\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

List tables/databases by workspace:

```bash
printf 'graph.database.list []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

List personal workspace tables only:

```bash
printf 'graph.database.list_personal []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Get current profile:

```bash
printf 'auth.profile []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

## Acting on Behalf of the User

Only make write calls when the user explicitly asks for the specific action. Read operations are fine for inspection. Mutating RPCs include calls such as `task.create_simple`, `task.update`, `task.complete`, `page.create`, `workspace.rename`, `organization.rename`, and `graph.database.update`.

Before writes:

1. Identify the exact RPC and arguments from `controller-rpc.d.ts`.
2. Explain the intended mutation to the user.
3. Confirm workspace/object IDs.
4. Run the command with stderr redirected.
5. Report the result and any relevant IDs.

For parsing multiple outputs, send one command per line and parse stdout as a stream of JSON values.
