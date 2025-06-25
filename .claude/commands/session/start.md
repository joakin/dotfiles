Start a new development session

<topic>
$ARGUMENTS
</topic>

Start by creating a session file in `.claude/sessions/` with the format `YYYY-MM-DD-HHMM-$TOPIC.md` (or just `YYYY-MM-DD-HHMM.md` if no name provided), where $TOPIC is a kebap case summary of what the user wrote.

The session file should begin with:

1. Session name and timestamp as the title
2. Session overview section with start time
3. Goals section (ask user for goals if not clear)
4. Empty progress section ready for updates

After creating the file, create or update `.claude/sessions/.current-session` to track the active session filename.

Confirm the session has started and remind the user they can:

- Update it with `/session:update`
- End it with `/session:end`

Once done, the main focus is on:

- Clarifying the user's goals
- Doing a research pass on the goals to determine the best next steps, and confirm with the user before starting to work
