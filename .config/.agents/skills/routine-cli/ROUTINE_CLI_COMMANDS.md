# Routine CLI Commands

Reference this file only when an existing script in `~/dev/routine/scripts` does not cover the user's request.

## Permissions

Run outside restrictive sandboxes when possible. The client reads and writes Routine's local saved auth/state, such as files under the user's Library/Saved Application State on macOS. If sandboxed, it may fail to reuse auth and queue RPCs before login.

Redirect stderr when parsing results. Routine logs go to stderr; command results are printed to stdout.

```sh
printf 'dev []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

## REPL Command Format

RPC call:

```text
<rpc.name> <json-array-args>
```

Examples:

```sh
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

For parsing multiple outputs, send one command per line and parse stdout as a stream of JSON values.

## Finding RPC Calls

Use the generated TypeScript RPC surface as the quickest index:

```sh
~/dev/routine/front/controller/controller-rpc.d.ts
```

Important sections:

- `organization`: `all`, `get`, `personal`, `workspaces.all`, member operations.
- `workspace`: `all`, `get`, `default`, `personalId`, member operations.
- `graph.database`: `list`, `listPersonal`, `get`, `defaultTypes.get`.
- `task`, `page`, `event`, `calendar`, `people`: user-facing Routine object APIs.

The source declarations live in:

```sh
~/dev/routine/front/api/controller/lib/rpcs/
```

Look for `call`, `call_async`, and `call_reactive`. From an external caller they all behave as commands that eventually print a result; in generated TypeScript they are exposed as promises. `call_reactive` may return a releasable reactive reference in the frontend, but the REPL prints the current value.

## Useful Read-Only Calls

List organizations:

```sh
printf 'organization.all []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Get an organization:

```sh
printf 'organization.get ["org:SMTbNfiPLsH79GsSzU75a"]\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

List all workspaces:

```sh
printf 'workspace.all []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Get a workspace:

```sh
printf 'workspace.get ["workspace:SMTbNfiPLsH79GsSzU75a"]\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

List tables/databases by workspace:

```sh
printf 'graph.database.list []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

List personal workspace tables only:

```sh
printf 'graph.database.list_personal []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

Get current profile:

```sh
printf 'auth.profile []\n' | ~/dev/routine/scripts/routine-cli 2>/tmp/routine-cli.log
```

## Mutating Calls

Only make write calls when the user explicitly asks for the specific action. Mutating RPCs include calls such as `task.create_simple`, `task.update`, `task.complete`, `page.create`, `workspace.rename`, `organization.rename`, and `graph.database.update`.

Before writes:

1. Identify the exact RPC and arguments from `controller-rpc.d.ts`.
2. Explain the intended mutation to the user.
3. Confirm workspace/object IDs.
4. Run the command with stderr redirected.
5. Report the result and any relevant IDs.
