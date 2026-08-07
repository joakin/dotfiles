---
name: routine-submit
description:
  Submit Routine frontend or API work to GitLab. Use when the user asks to
  submit a branch, create a GitLab MR, prepare work for review, approve an MR,
  or set GitLab auto-merge for these repositories.
---

# routine-submit

Use this skill to turn finished local work in `routine/front` or `routine/api`
into a clean GitLab merge request.

Be brief.

## Defaults

- GitLab host: `gitlab.routine.co`
- Git remote: `origin`
- Target branch: `master`, unless the user says otherwise
- Branch prefixes: `feature/`, `fix/`, or `sandbox/`
- MR tool: `glab`, not `gh`
- Frontend MR final state: pushed, assigned, approved if allowed, and added to
  the merge train when checks pass
- API MR final state: pushed and assigned; do not approve or enable auto-merge
  unless the user explicitly requests it

## Safety Rules

- Never run destructive Git commands unless the user explicitly requests them.
- Before committing, inspect `git status`, `git diff`, and recent `git log`.
- Do not include unrelated user changes, secrets, `.env` files, credentials, or
  generated noise.
- Treat "submit this" or "make an MR" as permission to create the needed branch,
  commits, push, and MR. For `routine/front`, this also permits approval and
  auto-merge. If the working tree contains ambiguous unrelated changes, ask
  first.
- When submitting `routine/api`, work in the API repository and create only the
  API MR. Do not update, commit, push, or create an MR for the frontend
  submodule pointer unless the user explicitly requests it.
- Do not use `--fill` for MR creation. Write the title and description manually
  from the actual diff and commits.
- Do not skip hooks unless the user explicitly requests it.
- Frontend MR descriptions must include a `/no-user-impact` checkbox. If the
  change has user impact, leave it unchecked and update `CHANGELOG.md` under
  `## [Unreleased]` using `### Added`, `### Changed`, or `### Fixed`.
- API MRs do not use the user-impact checkbox or this changelog procedure.

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
cross-cutting changes. If checks are skipped or fail, report that in the final
chat response. Do not add local validation details to the MR description.

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

## Why
The hint currently disappears when it is most useful, making reference search
harder to discover.

## Changelog
- [ ] /no-user-impact

EOF
)" \
  --remove-source-branch
```

Keep MR descriptions concise and focused on the change itself:

- `## Summary` describes the behavior or implementation changed. Include only
  information useful to reviewers and future readers.
- `## Why` is optional. Include it only when the motivation is not obvious from
  the summary, using relevant context from the conversation to explain the
  problem or reason for the change.
- `## Changelog` applies only to frontend MRs. Use
  `- [x] /no-user-impact` only when the MR has no user impact and does not need
  `CHANGELOG.md`. Use `- [ ] /no-user-impact` when there is user impact and
  include the changelog entry in the MR. Omit this section from API MRs.

Do not include test plans, validation steps, commands run, local test or build
results, environment-specific warnings, dependency issues, unrelated local
nitpicks, or implementation trivia that does not help explain the change.
Report checks, failures, skipped checks, and local-environment issues only in
the final chat response, not in the MR description.

7. Assign the MR to the user

8. For frontend MRs only, approve the MR if GitLab allows self-approval:

```sh
glab mr approve
```

If GitLab rejects approval because approval rules require another reviewer,
report that and leave the MR otherwise ready.

9. For frontend MRs only, add to the merge train when checks pass:

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

10. Final response:

- Include the MR URL.
- For frontend MRs, state whether approval succeeded and whether merge train /
  auto-merge was enabled.
- Summarize checks run and any skipped or failing checks.
