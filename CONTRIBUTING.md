# Contributing

## Workflow

1. Pick an issue labeled `Accepted`, assign it to yourself and switch its status label to `In progress`.
2. Create a branch from `main` named `{type}/{issue}-{short-description}`, e.g. `feat/42-quote-endpoint`.
3. Commit following the rules below. Enable the versioned hooks once with `git config core.hooksPath .githooks`; the pre-commit hook runs [gitleaks](https://github.com/gitleaks/gitleaks#installing); it must be installed or the commit fails.
4. Open a pull request into `main` following the PR rules below. CI must pass.
5. After merging, switch the issue to `Done` (closing keywords close it automatically).

## Labels

| Group | Labels | Meaning |
|---|---|---|
| Type | `💎Feature` `🛠️Chore` `🐛Bug` `📑Docs` | What kind of work it is |
| Difficulty | `🔴High` `🟡Medium` `🔵Low` | How hard it is — **not** its priority |
| Estimate | `🐭1.0` `🐰2.0` `🐶4.0` `🐘8.0` | Expected hours of work |
| Status | `Accepted` `In progress` `Done` | Where it is in the workflow |

Every issue has one label of each group. Anything bigger than 8 hours is split into smaller issues.

## Issues

Issues are written in English and must be workable by someone who has never touched that part of the code.

- **Tasks** (`💎Feature`, `🛠️Chore`, `📑Docs`): context, what has to be done, acceptance criteria and dependencies on other issues.
- **Bugs** (`🐛Bug`): describe the problem only — steps to reproduce, expected behavior, actual behavior and where it happens. Leave the solution to whoever takes the issue.

## Commit messages

Format: `{type}: {message}`

| Type | Use it for |
|---|---|
| `feat` | New functionality |
| `fix` | Bug fixes |
| `chore` | Tooling, dependencies, configuration, infrastructure, tests |
| `docs` | Documentation only |

Rules:

- One line, in English, lowercase type, no scope (`fix(deps):` is not allowed).
- The message is a very brief summary of the change — no bullet lists, no paragraphs, no commit body.
- No `Co-Authored-By` lines or any attribution to AI agents.

```
feat: add quote endpoint with server-side pricing     ✅
fix: return 404 when the product does not exist      ✅
docs: document key rotation                           ✅

Feat: Added the quote endpoint.                       ❌ capitalized type, past tense
fix(api): stuff                                       ❌ scope, says nothing
chore: update deps

- bump nestjs
- bump prisma                                         ❌ body with bullets
```

## Pull requests

**Title:** same format as commits. It can be a bit longer so it explains what the PR contains.

**Description**, in this order:

1. The related issue: `Closes #N`, `Addresses #N` (related but does not finish it) or `Part of #N` (one of several PRs for that issue).
2. `## Summary` — what changed.
3. `## Why` — the reason for the change.

```markdown
Closes #42

## Summary
Adds POST /quotes, which stores the quote and computes prices from the catalog.

## Why
Quote totals were calculated with prices sent by the client.
```

The repository's pull request template already has this structure.

## Comments

**Code comments:** keep them to the essential minimum. Only write a comment when the information cannot be inferred from the code itself (a non-obvious constraint, a security reason, a library quirk). Do not restate what the code does, and do not reference tasks, phases or TODOs — that belongs in issues.

**Issue and PR comments:** in English, short and specific. Reference files and lines or commits when pointing at code, and suggest changes instead of only describing them when possible.
