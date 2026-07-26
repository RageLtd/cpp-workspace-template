---
paths: ["*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx", "*.inl", "*.ipp", "*.ixx", "*.cppm"]
tools: ["Edit", "Write", "MultiEdit"]
---

# Field Comments

Every struct or class field gets a terse `@field_desc` block immediately above it. State what the field is or what it is used for, and nothing more.

```cpp
/*
 * @field_desc
 * - One-line summary of what this field is or what it is for.
 * - Optional second line only for a non-obvious invariant.
 */
uint32_t Index = UINT32_MAX;
```

Use one or two bullets, never more. If the concept needs more explanation, promote it into a named type with its own comment. Do not restate the type or duplicate the initializer. Cross-reference a meaningful initializer constant instead. Trivial helper aliases such as `using Fn = void(*)(...)` do not require their own field annotation because the surrounding type supplies their context.
