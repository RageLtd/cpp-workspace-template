---
globs: ["*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx", "*.inl", "*.ipp", "*.ixx", "*.cppm"]
tools: ["Edit", "Write", "MultiEdit"]
---

# Documentation Cross-References

Every reference to another defined symbol or file inside a documentation comment uses one `@crossref{...}` tag. Bare identifier mentions do not produce graph edges and are forbidden when the referenced thing has a definition.

Every cross-reference target must be fully qualified:

- Namespaced symbol: `@crossref{Namespace::Sub::Symbol}`.
- Member: `@crossref{Namespace::Type::Method}` or `@crossref{Type::Field}`.
- Global symbol: prefix it with `::`, as in `@crossref{::INVALID_ENTITY}` or `@crossref{::ForEachChunk}`.
- File: use a repository-relative forward-slash path, as in `@crossref{Source/.../File.h}`.

Use exactly one symbol per tag. Never put a comma-separated list inside one tag. Do not tag the current function's own name or its own parameters.

Tag every referenced function, type, member, enumerator, constant, and macro, including small symbols such as `IS_ALIVE`, `UINT32_MAX`, `Success`, and `Record`.

```cpp
/*
 * @func_desc
 * - Mint or re-mint the record at `idx`.
 * - Bumps Generation and sets @crossref{::EntityRecord::IS_ALIVE}.
 * @input
 * - idx:
 * -- Slot id handed back by @crossref{::ArchStorageT::AllocSlot}.
 * - reservation_id:
 * -- Owning reservation or @crossref{::INVALID_RESERVATION_ID} when none.
 * @output
 * - Freshly minted @crossref{::EntityRecord}.
 */
```
