# Logic Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Classical and three-valued (Strong Kleene) logic for Swift — a `Logic` namespace of operators, protocols, and result builders over `Bool` and `Bool?`, with zero platform dependencies.

---

## Quick Start

`Logic` is a small vocabulary for reasoning about truth values. `Bool` carries classical two-valued logic; `Bool?` carries three-valued logic where `nil` is the *unknown* value, following the Strong Kleene truth tables used by SQL and other systems that must reason in the presence of missing data.

Three-valued conditions read declaratively through result builders — `all` is conjunction, `any` is disjunction, `none` is its negation:

```swift
import Logic_Ternary_Primitives

let isAuthenticated: Bool? = true
let permissionLoaded: Bool? = nil   // still resolving — unknown
let withinQuota: Bool? = true

// Strong Kleene conjunction: `false` dominates, then `unknown`, then `true`.
let granted = Bool?.all {
    isAuthenticated
    permissionLoaded
    withinQuota
}
// granted == nil: with no definite `false`, an unknown input keeps the result unknown.
```

The same logic is available as operators and named functions. Classical operators work over any `Logic.Protocol` type (such as `Bool`); the three-valued operators propagate `unknown` through `Bool?`:

```swift
import Logic_Primitives   // umbrella: binary + ternary

// Classical, two-valued:
let parity = Logic.xor(true, false)        // true
let vacuous = Logic.implies(false, true)   // true

// Three-valued, unknown-propagating:
let changed = (true as Bool?) ^ nil        // nil — indeterminate
let same = (true as Bool?) !^ true         // true — equivalent
```

Conform your own types to `Logic.Protocol` (two-valued) or `Logic.Ternary.Protocol` (three-valued) to reuse every operator and builder.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-logic-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Logic Primitives", package: "swift-logic-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Import `Logic Primitives` for everything, or a narrower product to keep your surface small. `Logic Primitive` has no dependencies; the remaining targets compose on top of it.

| Product | Target | Purpose |
|---------|--------|---------|
| `Logic Primitive` | `Sources/Logic Primitive/` | The `Logic` namespace: the two-valued `Logic.Protocol`, the `Bool` conformance, and the classical operators `Logic.{and, or, not, xor, nand, nor, xnor, implies, iff}`. |
| `Logic Ternary Primitives` | `Sources/Logic Ternary Primitives/` | `Logic.Ternary`: Strong Kleene three-valued logic — the `Logic.Ternary.Protocol`, the `Bool?` conformance, the `!`, `^`, and `!^` operators with their short-circuiting AND / OR / NAND / NOR forms, and the `all` / `any` / `none` result builders. |
| `Logic Primitives` | `Sources/Logic Primitives/` | Umbrella that re-exports `Logic Primitive` and `Logic Ternary Primitives`. |
| `Logic Primitives Test Support` | `Tests/Support/` | Re-exports the umbrella for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
