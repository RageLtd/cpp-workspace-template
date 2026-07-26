---
paths: ["*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx", "*.inl", "*.ipp", "*.ixx", "*.cppm"]
tools: ["Edit", "Write", "MultiEdit"]
---

# Function Comments

Every function, including trivial accessors and one-line forwarders, gets a compact annotation block immediately above it. The LSP-based autodoc and vector database rely on wall-to-wall coverage.

```cpp
/*
 * @func_desc
 * - One-line summary.
 * - Optional second line for a non-obvious invariant or behavior.
 * @template_input
 * - typename Name:
 * -- One-line role.
 * @input
 * - param_name:
 * -- One-line role. Units, lifetime, or ownership only when non-obvious.
 * @output
 * - One-line description of the returned value, or `void`.
 */
```

Use bullets only, with no prose paragraphs and no blank lines between entries within a section. Omit empty sections. Every line must earn its place.

Do not restate types visible in the signature. Do not record history or say “previously.” Do not list call sites. State only present behavior.

Inside a function body, prefer clear code. Add a body comment only for a non-obvious invariant, workaround, or subtle constraint.

Leave one blank line between annotated fields, functions, types, and constants. Also leave one blank line between the end of one annotated declaration and the next annotation block. This keeps LSP entry-boundary detection cheap and the source readable.

The canonical example is `Source/Game/Simulation/Shared/ECS/EcsArchStorage.h` above `ForEachChunkParallel`.
