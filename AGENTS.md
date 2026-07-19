# Agent Instructions

## Rule loading

Before planning or changing code, read every applicable rule under
[.claude/rules](.claude/rules). Markdown frontmatter `globs` scope a rule to
matching files. Rules without `globs` apply to the whole repository. A
`.enforce.toml` file and the Markdown file named by its `body` field are one
rule and must remain together.

The `mimir` and `cpp` subtrees are repository-owned rule sets. The C++ rules
apply to matching project files. If two imported rules conflict, stop and ask
the developer which rule wins.

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
