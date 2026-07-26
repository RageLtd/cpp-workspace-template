# Agent Instructions

## Rule loading

Before planning or changing code, read every applicable rule under
[.claude/rules](.claude/rules). Markdown frontmatter `paths` scopes a rule to
matching files. Rules without `paths` apply to the whole repository. A
`.enforce.toml` file and the Markdown file named by its `body` field are one
rule and must remain together.

The key is `paths`, not `globs` — Claude Code ignores `globs` entirely, so a
rule carrying it loads in every session regardless of file type. A bare
`*.ext` pattern already matches nested files; `**/*.ext` is unnecessary. The
`exclude_globs` key inside a `.enforce.toml` is a different thing — that one
belongs to Mimir's rules engine and is spelled correctly as-is.

There are two kinds of rule here, and the difference matters:

- **Vendored** — everything directly under `.claude/rules/` (`coding/`,
  `quality/`, `safety/`, `tooling/`, `workflow/`). These are copies from the
  shared `claude-rules` set, listed with their digests in
  `.claude/rules-lock.json`. **Do not edit them.** A change here is invisible
  to every other repository and is overwritten on the next sync;
  `node .claude/rules-check.mjs` fails the build if one is touched. To change
  one, change it upstream, then re-sync.
- **Repository-owned** — the `cpp/` subtree. These belong to this project,
  are absent from the lock, and are yours to edit freely. The C++ rules apply
  to matching project files.

If a vendored rule and a `cpp/` rule conflict, stop and ask the developer
which wins — do not silently pick one.

## Ownership boundary

`.devcontainer/devcontainer.json` is the only configuration surface for the
development environment. `.devcontainer/Dockerfile` implements that
configuration. The environment does not generate repository files.

The project owns its CMake files, presets, dependencies, targets, compiler
flags, formatting rules, lint rules, Luau globals and aliases, and debugger
configuration. In particular, the environment must not generate or replace
`.clang-format`, `.clang-tidy`, `.clangd`, `.luaurc`, `.stylua.toml`, or
`.zed/debug.json`.

`.zed/settings.json` is a project-owned starter file. It may be extended or
replaced. The environment does not regenerate it.

## Verification

Run `devcontainer build --workspace-folder .` after changing the environment.
After changing the supplied tools, open the container and verify the relevant
executables. Once an actual project is present, use the build and test commands
defined by that project.
