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

```bash
# Stage specific files (preferred)
git add path/to/changed/file.ts

# Commit with concise message using heredoc
git commit -m "$(cat <<'EOF'
Brief summary of what was changed

Optional explanation of why the change was needed and what it fixes.

Key changes:
- Bullet point of main changes
- Another important change

Fixes/addresses the core issue described.
EOF
)"
```

## 3. Push Branch (if needed)
```bash
git push -u origin branch-name
```

Take note of the *create merge request* link in the output.

## 4. Write MR Description
Create `.mr.md` with this structure:
```markdown
https://link-to-create-merge-request-goes-here

## Brief title matching commit summary

**Problem**: Clear description of what was broken or needed.

**Solution**: Concise explanation of how it was fixed.

**Testing**: 
- ✅ Test case 1 description
- ✅ Test case 2 description

**Files changed**: `path/to/file.ts`, `path/to/other.ts`
```

## Guidelines
- **Branch names**: Use `fix/` for bugs, `feature/` for new functionality
- **Commit messages**: Focus on what and why, not how unless interesting
- **MR descriptions**: Problem → Solution → Testing → Lessons learnt
- **Keep it concise**: No redundant information or verbose explanations
