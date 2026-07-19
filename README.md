# Portable C++ and Luau Environment for Zed

This repository supplies a reproducible development environment, not a CMake project or a project policy pack. Nix pins LLVM/Clang, clangd, LLDB, CMake, Ninja, ccache, Luau's command-line tools and language server, and StyLua. direnv makes that environment available to terminals and Zed.

Each project owns every decision about how those tools are used.

## First use

Install [Nix with flakes enabled](https://nixos.org/download/) and [direnv](https://direnv.net/), then run:

```sh
direnv allow
zed .
```

`direnv allow` approves the repository's `.envrc`. Zed loads that environment directly, so its language servers and terminals see the same pinned tools. Run `nix develop` when an explicit development subshell is preferable.

Install the `Luau` extension once from Zed's Extension Gallery. C++ support and clangd integration are native to Zed.

## Environment configuration

`workspace.nix` is the single human-edited environment configuration. It contains only:

- Project display metadata.
- Supported host systems.
- The LLVM package-set selector.
- Optional additional nixpkgs packages.

Exact package revisions belong to `flake.lock`. Run `nix flake update` when the environment should intentionally advance.

Direnv watches the environment files and reloads them when they change. Run `nix flake check` to validate the flake after editing the environment.

## Project ownership

The environment does not create or modify any of these project files:

- `CMakeLists.txt`, CMake modules, or CMake presets.
- `.clang-format`, `.clang-tidy`, or `.clangd`.
- `.luaurc` or `.stylua.toml`.
- `.zed/debug.json` or project build, test, and analysis tasks.

The committed `.zed/settings.json` is a small, project-owned starter amenity that connects Zed to direnv and configures Luau tooling. It is not generated and may be edited or replaced by the project.

Projects can add their own build, test, analysis, formatting, language-server, and debugger configuration without changing the environment machinery.

## Portability

The flake exposes native shells for Apple Silicon macOS and both ARM64 and x86-64 Linux. Current nixpkgs no longer supports Intel macOS. Windows uses the Linux shell through WSL.

Agent rules are committed under `.claude/rules`. `AGENTS.md` is their portable entry point for Zed and other coding agents.
