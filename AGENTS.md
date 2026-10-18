# Agent Instructions

This is the Homebrew tap for Basic Memory. It holds two formulas:
`Formula/basic-memory.rb` (stable) and `Formula/basic-memory-beta.rb`
(pre-releases, version chosen at install time with `BM_VERSION`).

## This repository is public

Everything you write here is public and permanent: issues, pull request
titles and descriptions, review comments, commit messages, code comments,
and files. GitHub keeps edit history, and search engines and mirrors copy
pages quickly. Deleting text later does not take it back.

**Write only what a stranger needs to understand the change.** The reader
is a Homebrew user or a contributor, not the maintainer's own setup.

### Never include

- **People's names** other than public GitHub handles already on the
  thread. Do not address the maintainer by name ("X: review and merge").
  Say "a maintainer" or leave the owner out.
- **Machine names and hostnames**, such as the name of the Mac where you
  ran a command.
- **Home directory paths and usernames**, such as `/Users/<name>/...`.
  Write `~/...` or describe the location instead.
- **Private tooling and process**: internal CLIs, sync jobs, launchd
  agents, fleet or provisioning scripts, and how the maintainer's machines
  use this tap.
- **Private repositories, ticket keys and board names** from trackers
  outside this repository.
- **Customer, employer or business details** that are not already public.
- **Secrets of any kind**: tokens, keys, email addresses, IP addresses,
  internal URLs.

### Describe the environment generically

Give the facts that affect the bug, and nothing that identifies whose
machine it is:

- Good: "On macOS 15, Apple Silicon, Homebrew 7.0, uv 0.13.1, the install
  fails with: ..."
- Bad: the hostname, the person who owns the Mac, or the private job that
  triggered the install.

When you quote command output or a log, check it for the items above
before pasting it. Replace a home path with `~`, and cut lines that only
show local setup.

### Next steps in a PR or issue

End with the next step for the project, not for a private setup. "A
maintainer reviews and merges; the next `brew upgrade` picks up the fix"
is fine. Follow-up work on the maintainer's own machines belongs in their
private notes, not here.

### Check before you post

Before you open or edit an issue or PR, push a commit, or post a comment,
reread the text for every item in **Never include**. If a detail matters
to the maintainer but not to the public, leave it out of GitHub and report
it to the maintainer in your session instead.
