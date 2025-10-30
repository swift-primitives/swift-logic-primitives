# Swift Logic Operators

[![CI](https://github.com/coenttb/swift-logic-operators/workflows/CI/badge.svg)](https://github.com/coenttb/swift-logic-operators/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Logical operators for optional Boolean values and predicates in Swift.

## Overview

Swift Logic Operators extends Swift's logical operators to work with optional Boolean values and predicate functions (closures returning `Bool`). It provides type-safe implementations of common logical operations that handle `nil` values gracefully and compose predicates functionally.

## Features

- **Optional Boolean Operators**: NOT (`!`), AND (`&&`), OR (`||`), XOR (`^`), NAND (`!&&`), NOR (`!||`), XNOR (`!^`)
- **Predicate Composition**: Combine and transform `(A) -> Bool` closures with logical operators
- **Nil-Safe**: All optional operators return `nil` when any operand is `nil`
- **Type-Safe**: Compile-time guarantees for logical operations
- **Error Handling**: Support for throwing closures with `rethrows`

## Installation

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-logic-operators.git", from: "0.1.0")
]
```

Then add the product to your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "LogicOperators", package: "swift-logic-operators")
        ]
    )
]
```

## Quick Start

```swift
import LogicOperators

// Optional Boolean operations
let a: Bool? = true
let b: Bool? = nil
let result = a && b  // nil

// Predicate composition
let isEven: (Int) -> Bool = { $0 % 2 == 0 }
let isPositive: (Int) -> Bool = { $0 > 0 }
let isEvenAndPositive = isEven && isPositive

isEvenAndPositive(4)  // true
isEvenAndPositive(-4) // false
```

## Usage

### Optional Boolean Operators

All optional Boolean operators propagate `nil` values:

```swift
let t: Bool? = true
let f: Bool? = false
let n: Bool? = nil

// NOT
!t  // false
!f  // true
!n  // nil

// AND
t && f  // false
t && n  // nil
f && n  // nil

// OR
t || f  // true
t || n  // true
f || n  // nil

// XOR
t ^ f  // true
t ^ n  // nil
f ^ f  // false

// NAND
(t !&& f)  // true
(t !&& t)  // false

// NOR
(t !|| f)  // false
(f !|| f)  // true

// XNOR
(t !^ f)  // false
(t !^ t)  // true
```

### Predicate Composition

Combine Boolean predicates using logical operators:

```swift
let isEven: (Int) -> Bool = { $0 % 2 == 0 }
let isPositive: (Int) -> Bool = { $0 > 0 }

// AND
let isEvenAndPositive = isEven && isPositive
isEvenAndPositive(4)  // true
isEvenAndPositive(-4) // false

// OR
let isNegative: (Int) -> Bool = { $0 < 0 }
let isEvenOrNegative = isEven || isNegative
isEvenOrNegative(3)  // false
isEvenOrNegative(-3) // true

// NOT
let isOdd = !isEven
isOdd(5)  // true
isOdd(4)  // false

// XOR
let isEvenXorPositive = isEven ^ isPositive
isEvenXorPositive(4)  // false (both true)
isEvenXorPositive(-4) // true  (even but not positive)
isEvenXorPositive(3)  // true  (positive but not even)
isEvenXorPositive(-3) // false (neither)

// Equality
let same = isEven == isPositive
same(4)  // true (both predicates return true for 4)
same(-4) // false (isEven true, isPositive false)
same(3)  // false (isEven false, isPositive true)
same(-3) // true (both predicates return false for -3)

// Inequality
let different = isEven != isPositive
different(4)  // false (both predicates return true)
different(-4) // true (different results)
different(3)  // true (different results)
different(-3) // false (both predicates return false)
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.
