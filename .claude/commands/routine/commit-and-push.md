# Git Workflow Commands for Claude Code in Routine repos

Time to commit, follow the steps below:

## 1. Create Feature/Fix Branch

If not already in a branch:

```bash
# For new features
git checkout -b feature/brief-description

# For bug fixes  
git checkout -b fix/brief-description
```

## 2. Stage and Commit Changes

Look at the git diff before staging. Commit in logical changes as much as
needed. Never add everything blindly.

Be brief, never mention types check or tests pass anywhere. Only relevant
information.

```bash
# Stage specific files (preferred)
git add path/to/changed/file.ts

# Commit with concise message using heredoc
git commit -m "$(cat <<'EOF'
Brief summary of what was changed

Optional explanation of why the change was needed and what it fixes.

- Bullet point of main changes
- Another important change
EOF
)"
```

## 3. Push Branch (if needed)
```bash
git push -u origin branch-name
```

Take note of the *create merge request* link in the output.

## 4. Write MR Description

Be brief, never mention types check or tests pass anywhere. Only relevant
information.

Create `.mr.md` with this structure:
```markdown
https://link-to-create-merge-request-goes-here

## Brief title matching commit summary

Clear description of what was broken or needed.

Concise explanation of how it was fixed.

- Bullet point of main changes
- Another important change
```

## Guidelines
- **Branch names**: Use `fix/` for bugs, `feature/` for new functionality
- **Commit messages**: Focus on what and why, not how unless interesting. Be
  brief.
- **MR descriptions**: Be brief and human.
- **Keep it concise**: No redundant information or verbose explanations
