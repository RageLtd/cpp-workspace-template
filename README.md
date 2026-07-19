# Portable C++ and Luau Dev Container for Zed

This repository supplies a containerized development environment, not a CMake project or a project policy pack. The image contains LLVM/Clang, clangd, LLDB, GDB, CMake, Ninja, ccache, Luau's command-line tools and language server, and StyLua. Zed runs terminals and language servers inside the container.

Each project owns every decision about how those tools are used.

## First use

Install [Docker](https://docs.docker.com/engine/install/) or Podman and a current version of [Zed](https://zed.dev/docs/dev-containers), then open the repository:

```sh
zed .
```

Zed detects `.devcontainer/devcontainer.json` and offers to build and reopen the repository in the container. The same configuration also works with other tools that implement the [Development Container Specification](https://containers.dev/).

The container configuration requests the Luau extension for Zed. C++ support and clangd integration are native to Zed.

## Environment configuration

`.devcontainer/devcontainer.json` is the single human-edited environment configuration. Its `build.args` block selects:

- The Alpine release, which supplies the C++ and Luau toolchain.
- The luau-lsp release and architecture-specific checksums.

`Dockerfile` installs the toolchain from Alpine packages and should not contain project policy. Both AMD64 and ARM64 images use the same definition; luau-lsp is the only downloaded tool because Alpine does not package it.

Zed does not currently rebuild a running dev container after configuration changes. Stop the existing container and reopen the repository in Zed to apply an update. The reference CLI can validate or build the same definition with `devcontainer build --workspace-folder .`.

## Project ownership

The environment does not create or modify any of these project files:

- `CMakeLists.txt`, CMake modules, or CMake presets.
- `.clang-format`, `.clang-tidy`, or `.clangd`.
- `.luaurc` or `.stylua.toml`.
- `.zed/debug.json` or project build, test, and analysis tasks.

The committed `.zed/settings.json` is a small, project-owned starter amenity that configures Luau tooling. It is not generated and may be edited or replaced by the project.

Projects can add their own build, test, analysis, formatting, language-server, and debugger configuration without changing the environment machinery.

## Portability

The container builds natively for Linux AMD64 and ARM64 hosts, including Docker Desktop on Intel and Apple Silicon macOS. Windows can use Docker Desktop or a compatible container engine through WSL 2.

Agent rules are committed under `.claude/rules`. `AGENTS.md` is their portable entry point for Zed and other coding agents.
