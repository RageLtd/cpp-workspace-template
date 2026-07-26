---
paths: ["*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx", "*.inl", "*.ipp", "*.ixx", "*.cppm", "*.m", "*.mm", "*.rs", "*.go", "*.java", "*.kt", "*.kts", "*.cs", "*.ts", "*.tsx", "*.js", "*.jsx", "*.mts", "*.mjs", "*.swift", "*.php", "*.rb"]
tools: ["Edit", "Write", "MultiEdit"]
---

# Control Blocks Require Braces

No control block (`if`, `for`, `while`, `do`, `switch`, and equivalent constructs) may omit its braces, even when its body contains only one statement. This rule applies to every language target in the repository.

```cpp
// Good.
if (slot >= kMaxEntities) { return; }

for (int32_t i = 0; i < n; ++i) { work(i); }

// Bad.
if (slot >= kMaxEntities) return;
for (int32_t i = 0; i < n; ++i) work(i);
```
