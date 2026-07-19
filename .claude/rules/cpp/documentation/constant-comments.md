---
globs: ["*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx", "*.inl", "*.ipp", "*.ixx", "*.cppm"]
tools: ["Edit", "Write", "MultiEdit"]
---

# Constant Comments

Every global constant and every namespace- or file-scope `static constexpr` gets a `@const_desc` block. A `static constexpr` inside a struct uses `@field_desc` because it is structurally a field.

```cpp
/*
 * @const_desc
 * - Sentinel value stored in @crossref{::EntityRegistry::LookupResult::Record} on lookup miss.
 */
constexpr EntityRecord INVALID_ENTITY = EntityRecord{};
```

Use one or two bullets. State what the value means rather than repeating its literal initializer. If the constant is a bit position, cap, or index into another structure, cross-reference the owning entity.
