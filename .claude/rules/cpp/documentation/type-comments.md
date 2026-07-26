---
paths: ["*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx", "*.inl", "*.ipp", "*.ixx", "*.cppm"]
tools: ["Edit", "Write", "MultiEdit"]
---

# Type Comments

Every `struct`, `class`, and scoped or plain `enum` gets a terse `@type_desc` block. State what the type is and, when non-obvious, its one-line invariant.

```cpp
/*
 * @type_desc
 * - Deterministic wire id and generation stamp for an ECS entity.
 * - Location bits are unbound until @crossref{::EntityRegistry::Bind}.
 */
struct EntityRecord { ... };

/*
 * @type_desc
 * - Runtime tag identifying which archetype storage owns an entity.
 */
enum class ArchKind : uint8_t { ... };
```

Use one or two description bullets, never more. Do not write a mini-manual. If layout, usage, or ownership genuinely needs more explanation, place it in a standalone `// ── Name ──` banner comment above the block.

Annotate an enumerator with `@field_desc` when its meaning is not obvious from its name.

Every template parameter must appear under `@template_input`, including apparently obvious parameters. Each entry has one bullet naming the parameter and one indented bullet describing its role.

```cpp
/*
 * @type_desc
 * - Chunked SoA storage parameterised by a component tuple.
 * @template_input
 * - typename Concrete:
 * -- CRTP self-type; exposes the archetype's `Kind` through the base.
 * - typename Schematic_:
 * -- Schematic whose `Components` tuple names the columns.
 * - int32_t MaxEntities_:
 * -- Reservation upper bound.
 */
template <typename Concrete, typename Schematic_, int32_t MaxEntities_>
struct ArchStorageT { ... };
```
