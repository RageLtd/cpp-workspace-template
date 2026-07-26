---
paths: ["*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx", "*.inl", "*.ipp", "*.ixx", "*.cppm"]
tools: ["Edit", "Write", "MultiEdit"]
---

# Function Stanzas

Functions read as a sequence of **stanzas**. A stanza is a tight group of related statements. Blank lines separate stanzas; no blank lines appear inside one.

```cpp
uint32_t AllocSlot()
{
    const uint32_t recycled = RecycledSlots.Alloc();
    if (recycled != FreeIdStack::kInvalid) { return recycled; }

    const uint32_t fresh = SlotWatermark.fetch_add(1u, std::memory_order_relaxed);
    if (fresh < static_cast<uint32_t>(kMaxEntities)) { return fresh; }

    SlotWatermark.fetch_sub(1u, std::memory_order_relaxed);

    return EcsConstants::InvalidEntityId;
}
```

Place blank lines between logically distinct steps such as setup, guard, work, and return. A guarded early return belongs to the guard's stanza; the following code starts a new stanza. Put a blank line before a terminal `return` after substantive work, but keep a one-line return with no prior work flush. Give a substantive `for` block or `if`/`else` block breathing room on both sides.

Do not put blank lines inside tightly coupled writes, immediately after `{`, immediately before `}`, or between a declaration and its first use unless a real stanza boundary falls there.

```cpp
c->Entities[row] = eid;
c->SetRowAlive(static_cast<int32_t>(row));
```

Alignment within a stanza is welcome when it aids scanning:

```cpp
r.Index           = abs_idx;
r.ReservationId   = reservation_id;
r.ChunkIdx        = 0;
r.Row             = 0;
r.Flags          |= EntityRecord::IS_ALIVE;
r.Generation     += 1u;
```

Do not force alignment across stanzas. The blank line already separates them, and cross-stanza column alignment adds noise.

The canonical reference is `Source/Game/Simulation/Shared/ECS/Core/ArchStorageT.h`, particularly `AllocSlot`, `AllocateAt`, `AllocateRecord`, and `BindRecord`.
