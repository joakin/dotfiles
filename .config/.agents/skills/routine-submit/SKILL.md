---
name: routine-submit
description:
  Submit Routine frontend work to GitLab. Use when the user asks to submit a
  branch, create a GitLab MR, prepare work for review, approve an MR, or set
  GitLab auto-merge for this repository.
---

# routine-submit

Use this skill to turn finished local work in `routine/front` into a clean
GitLab merge request.

Be brief.

## Defaults

- GitLab host: `gitlab.routine.co`
- Git remote: `origin`
- Target branch: `master`, unless the user says otherwise
- Branch prefixes: `feature/`, `fix/`, or `sandbox/`
- MR tool: `glab`, not `gh`
- Preferred MR final state: pushed, approved if allowed, and added to merge
  train when checks pass

## Safety Rules

- Never run destructive Git commands unless the user explicitly requests them.
- Before committing, inspect `git status`, `git diff`, and recent `git log`.
- Do not include unrelated user changes, secrets, `.env` files, credentials, or
  generated noise.
- Treat "submit this" or "make an MR" as permission to create the needed branch,
  commits, push, MR, approval, and auto-merge. If the working tree contains
  ambiguous unrelated changes, ask first.
- Do not use `--fill` for MR creation. Write the title and description manually
  from the actual diff and commits.
- Do not skip hooks unless the user explicitly requests it.
- Every MR description must include a `/no-user-impact` checkbox. If the change
  has user impact, leave it unchecked and update `CHANGELOG.md` under
  `## [Unreleased]` using `### Added`, `### Changed`, or `### Fixed`.

## Workflow

1. Verify context:

```sh
git status --short --branch
git remote -v
git log --oneline --decorate -n 8
glab auth status --hostname gitlab.routine.co
```

2. If currently on `master` or another unsuitable base branch, create a branch:

```sh
git switch -c fix/descriptive-kebab-name
```

Choose the prefix by intent:

- `fix/` for bug fixes or regressions
- `feature/` for new behavior or user-visible enhancements
- `sandbox/` for experiments, spikes, or throwaway work

3. Commit in logical units.

Group changes by reviewable concern, not by file count. Use concise messages
that explain the purpose:

```sh
git add <relevant-files>
git commit -m "$(cat <<'EOF'
fix: keep reference search hint visible

Explain why the change is needed, not just which files changed.
EOF
)"
```

If hooks modify files, inspect the result and create a new commit for any
remaining fixes. Only amend when the normal agent Git safety rules allow it.

4. Run checks appropriate to the changed surface:

```sh
make check/front
```

Use `make check/controller` for controller changes and `make check` for broad or
cross-cutting changes. If checks are skipped or fail, state that clearly in the
MR description.

5. Push the branch:

```sh
git push -u origin HEAD
```

6. Create the MR with a hand-written title and body:

```sh
glab mr create \
  --target-branch master \
  --title "Fix reference search hint visibility" \
  --description "$(cat <<'EOF'
## Summary
- Keep the reference search hint visible in the relevant editor state.
- Preserve existing interaction behavior while making the hint easier to discover.

## Changelog
- [ ] /no-user-impact

EOF
)" \
  --remove-source-branch
```

Keep MR descriptions specific. Mention the user-facing effect, important
implementation choices, and exactly what was tested. For the changelog checkbox:
use `- [x] /no-user-impact` only when the MR has no user impact and does not
need `CHANGELOG.md`. Use `- [ ] /no-user-impact` when there is user impact and
include the changelog entry in the MR.

7. Approve the MR if GitLab allows self-approval:

```sh
glab mr approve
```

If GitLab rejects approval because approval rules require another reviewer,
report that and leave the MR otherwise ready.

8. Add to merge train when checks pass:

```sh
glab api graphql \
  -f query='mutation($projectPath: ID!, $iid: String!, $sha: String!) {
    mergeRequestAccept(input: {
      projectPath: $projectPath,
      iid: $iid,
      sha: $sha,
      strategy: ADD_TO_MERGE_TRAIN_WHEN_CHECKS_PASS,
      shouldRemoveSourceBranch: true
    }) {
      errors
      mergeRequest {
        iid
        webUrl
        mergeWhenPipelineSucceeds
        autoMergeEnabled
        detailedMergeStatus
      }
    }
  }' \
  -f projectPath='routine/front' \
  -f iid='<mr-iid>' \
  -f sha="$(git rev-parse HEAD)"
```

Do not use `glab mr merge --auto-merge` for this project; it returns
`405 Method Not Allowed`. The project uses merge trains, and
`ADD_TO_MERGE_TRAIN_WHEN_CHECKS_PASS` is the working auto-merge path.

9. Final response:

- Include the MR URL.
- State whether approval succeeded.
- State whether merge train / auto-merge was enabled.
- Summarize checks run and any skipped or failing checks.
