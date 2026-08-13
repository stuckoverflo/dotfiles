## Writing & Communication

- No word slop. Cut filler, hedging, and restated context. Say the thing.
- PR descriptions: short summary section up top, details (if any) in a separate section below. Always check for a PR template first and use it.
- Trim iteration remnants — docstrings/comments that accumulated cruft across edits should be tightened to just what's needed to understand the thing, not padded, not cryptic.
- Don't document removed or hypothetical options ("don't use X" for an X that no longer exists). Document current state only, not history.
- First-run/setup instructions: bare numbered steps, no surrounding exposition, unless I ask for explanation.
- Status/summary output (standups, changelists, daily rollups): one line per item, scannable, no prose padding.
- Draft-then-show for anything externally facing (Slack messages, PR text, emails): show me the draft before sending. One-liners for casual async messages.
- When something is genuinely ambiguous, ask for my take or state a recommendation with the main tradeoff — don't silently pick and don't over-explain the options either.

## Git / PR Workflow

- Draft PRs by default. Conventional Commits, ticket ID in the message when one exists.
- Check for a repo's PR template before writing any PR description.
- Never force-push without approval; `--force-with-lease` when approved (exception: known-safe personal/solo branches — I'll say so explicitly).
- Use `git worktree add` for parallel branches, not `checkout -b` in the same tree.
- Personal/public repos: no work email in commit identity; scrub secrets before anything becomes public.

## Code Style

- Tests: simple, one mock seam, readable over clever. No spaghetti mocking machinery.
- No comments explaining _what_ code does — only _why_, and only when genuinely non-obvious.
- Don't add abstractions, error handling, or config for cases that can't happen. Match effort to what was asked.
- Prefer zero-dependency / minimal-tooling solutions when the task doesn't need more (vanilla over framework, script over service). If there's a need, ask
- One-off scripts: `uv run` with PEP 723 inline deps, no manual venvs, no shebang unless the environment is controlled.

## Review & Collaboration

- Code review comments should name the specific failure mode and a minimal fix — not vague "consider tightening this" concerns.
- For infra/config changes, check cross-environment consistency, not just correctness in isolation.
- Secrets: confirm existence/count only, never print values.
- Casual, unpolished voice is fine for my own throwaway/personal projects — don't formalize docs I've deliberately kept casual.

## Notes & Handoffs

Capture durable findings as a zettel, link a short summary into the day's journal — treat this as the session handoff mechanism.

Obsidian Vault: <flo fill this in>
"Notes" = this vault.

### Zettels (00-inbox/)

- Template: templates/a_nvim_zettel.md
- Filename: `YYYYMMDDHHmm-kebab-case-title.md` (timestamp = creation time)
- Frontmatter `title:` = same title with hyphens replaced by spaces
- "Create a note for this" (mid-session) = create a zettel here, then add a one-line link to it in today's journal entry (create today's journal file first if missing)

### Journal (01-journal/)

- Template: templates/nvim-daily.md
- Filename: `YYYYMMDD.md`, one file per day
- "The journal" / "today's journal" / "last Monday's journal" = the file for that date in this folder
