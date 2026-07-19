# Imported Project Rules

These rules are committed so every clone and editor agent uses the same policy without depending on paths outside the repository.

| Subtree | Scope |
| --- | --- |
| `rules/mimir` | General repository policy |
| `rules/cpp` | C++ policy |

The files are intentionally preserved rather than merged. This keeps frontmatter scopes and `.enforce.toml` body paths intact. `AGENTS.md` is the portable entry point for agents, including Zed's agent.
