// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// MARK: - AND

extension Logic {
    /// Performs logical AND.
    ///
    /// Returns `true` only if both operands are `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.and(true, false)  // false
    /// Logic.and(true, true)   // true
    /// ```
    @inlinable
    public static func and<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs), let r = T.from(rhs) else {
            // For binary logic this won't happen, but supports extension
            return .false
        }
        return T(l && r)
    }
}

// MARK: - OR

extension Logic {
    /// Performs logical OR.
    ///
    /// Returns `true` if either operand is `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.or(true, false)   // true
    /// Logic.or(false, false)  // false
    /// ```
    @inlinable
    public static func or<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs), let r = T.from(rhs) else {
            return .false
        }
        return T(l || r)
    }
}

// MARK: - NOT

extension Logic {
    /// Performs logical NOT (negation).
    ///
    /// Returns the logical negation of the operand.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.not(true)   // false
    /// Logic.not(false)  // true
    /// ```
    @inlinable
    public static func not<T: `Protocol`>(_ value: T) -> T {
        guard let v = T.from(value) else {
            return value
        }
        return T(!v)
    }
}

// MARK: - XOR

extension Logic {
    /// Performs logical XOR (exclusive OR).
    ///
    /// Returns `true` if exactly one operand is `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.xor(true, false)  // true
    /// Logic.xor(true, true)   // false
    /// ```
    @inlinable
    public static func xor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs), let r = T.from(rhs) else {
            return .false
        }
        return T(l != r)
    }
}

// MARK: - NAND

extension Logic {
    /// Performs logical NAND (NOT AND).
    ///
    /// Returns `false` only if both operands are `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.nand(true, true)   // false
    /// Logic.nand(true, false)  // true
    /// ```
    @inlinable
    public static func nand<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.not(Self.and(lhs, rhs))
    }
}

// MARK: - NOR

extension Logic {
    /// Performs logical NOR (NOT OR).
    ///
    /// Returns `true` only if both operands are `false`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.nor(false, false)  // true
    /// Logic.nor(true, false)   // false
    /// ```
    @inlinable
    public static func nor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.not(Self.or(lhs, rhs))
    }
}

// MARK: - XNOR

extension Logic {
    /// Performs logical XNOR (equivalence, NOT XOR).
    ///
    /// Returns `true` if both operands have the same value.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.xnor(true, true)    // true
    /// Logic.xnor(false, false)  // true
    /// Logic.xnor(true, false)   // false
    /// ```
    @inlinable
    public static func xnor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.not(Self.xor(lhs, rhs))
    }
}

// MARK: - Implication

extension Logic {
    /// Performs logical implication (material conditional).
    ///
    /// `implies(a, b)` is equivalent to `!a || b`.
    /// Returns `false` only when `lhs` is `true` and `rhs` is `false`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.implies(true, true)   // true
    /// Logic.implies(true, false)  // false
    /// Logic.implies(false, true)  // true
    /// Logic.implies(false, false) // true
    /// ```
    @inlinable
    public static func implies<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.or(Self.not(lhs), rhs)
    }
}

// MARK: - Biconditional

extension Logic {
    /// Performs logical biconditional (if and only if).
    ///
    /// Returns `true` if both operands have the same truth value.
    /// This is equivalent to XNOR.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Logic.iff(true, true)    // true
    /// Logic.iff(false, false)  // true
    /// Logic.iff(true, false)   // false
    /// ```
    @inlinable
    public static func iff<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        Self.xnor(lhs, rhs)
    }
}
