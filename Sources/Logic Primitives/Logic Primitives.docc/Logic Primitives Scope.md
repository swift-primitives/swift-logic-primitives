# Logic Primitives Scope

`swift-logic-primitives` provides the **logic-system substrate**: the `Logic`
namespace, the base `Logic.Protocol` (true/false) with its standard binary
operators, and the ternary (three-valued, Strong Kleene) logic extension. It is
the foundational vocabulary every higher logic system (binary, ternary, and
future fuzzy / multi-valued logics) builds on.

## Per-[MOD-031] shape

The package follows `[MOD-031]` per-sub-namespace decomposition: `Logic Primitive`
is the layer-invariant namespace target per `[MOD-017]`, and each external-dep-
bearing or independently-versioned sub-namespace is its own target. There is no
implementation-bearing `Logic Primitives Core` target — the legacy `[MOD-001]`
Core convention is deprecated. During the L1 core-dissolution sweep (2026-06-23)
the Core's content was relocated to the `Logic Primitive` root and the
`Logic Primitives Core` target was reduced to a time-boxed exports-only shim
(removed in the cleanup wave).

## Owner targets

- **Logic Primitive** — the `public enum Logic {}` namespace target. Zero external
  deps per `[MOD-017]`'s invariant. Owns `Logic.Protocol` (the base binary-logic
  protocol), the `Bool: Logic.Protocol` conformance, and the binary operator
  functions (`Logic.and` / `or` / `not` / `xor` / `nand` / `nor` / `xnor` /
  `implies` / `iff`). All stdlib-only.
- **Logic Ternary Primitives** — the `Logic.Ternary` namespace: three-valued
  (Strong Kleene) logic — `Logic.Ternary.Protocol` (adds `unknown`), the
  `Bool?` conformance, the throwing + non-throwing Strong Kleene operators
  (`&&`, `||`, `!`, `^`, `!&&`, `!||`, `!^`), and the `Logic.Ternary.Builder`
  result builders (`All` / `Any` / `None`). Depends only on `Logic Primitive`.
- **Logic Primitives** — umbrella; re-exports `Logic Primitive` + `Logic Ternary
  Primitives` so consumers needing the union write `import Logic_Primitives`.
- **Logic Primitives Core** — DEPRECATED time-boxed shim (exports-only). Re-exports
  the pre-migration Core surface (`Logic Primitive` + the `Standard Library
  Extensions` funnel) so no consumer breaks during the sweep. Removed in the
  cleanup wave.
- **Logic Primitives Test Support** — published test-fixtures product.

## Out of scope

- Bit-level / vector logic (`Bit`, `Bit.Vector`) — `swift-bit-vector-primitives`.
- Fuzzy / continuous-valued logics — a future sibling package when needed.

## Evaluation rule

Sub-target additions are evaluated against this scope.

- A proposed addition that is a **stdlib-only foundational logic decl** (a
  namespace, the base protocol, a binary operator) lands in the zero-dep
  `Logic Primitive` root.
- A proposed addition that is a **distinct logic system** (a new many-valued or
  fuzzy logic) or **requires an external dependency** lands as its own
  sub-namespace target per `[MOD-031]`, declaring that dependency itself.
