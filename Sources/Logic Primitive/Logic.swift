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

/// Namespace for logic types and operations.
///
/// Logic primitives provide foundational types and protocols for implementing
/// various logic systems: binary (classical), ternary (three-valued), and beyond.
///
/// ## Example
///
/// ```swift
/// // Binary logic
/// let a: Bool = true
/// let b: Bool = false
/// let result = a && b  // false
///
/// // Using the Logic namespace
/// let and = Logic.and(a, b)  // false
/// ```
public enum Logic {}

// MARK: - Protocol

extension Logic {
    /// A type that represents a logic system with true and false values.
    ///
    /// Conforming types gain standard logic operators (`&&`, `||`, `!`, `^`)
    /// through protocol extensions. This is the base protocol for binary logic;
    /// multi-valued logics (ternary, fuzzy) extend this with additional values.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Bool already conforms implicitly through Swift's standard library
    /// // Custom types can conform:
    /// enum Bit: Logic.Protocol {
    ///     case zero, one
    ///
    ///     static var `true`: Bit { .one }
    ///     static var `false`: Bit { .zero }
    ///
    ///     static func from(_ value: Bit) -> Bool {
    ///         value == .one
    ///     }
    ///
    ///     init(_ bool: Bool) {
    ///         self = bool ? .one : .zero
    ///     }
    /// }
    /// ```
    public protocol `Protocol`: Sendable {
        /// The true value in this logic system.
        static var `true`: Self { get }

        /// The false value in this logic system.
        static var `false`: Self { get }

        /// Converts a value of this logic type to its boolean representation.
        ///
        /// For binary logic, this is a direct mapping. For multi-valued logics,
        /// this returns `nil` for values that are neither true nor false.
        static func from(_ value: Self) -> Bool?

        /// Creates a value from a boolean.
        ///
        /// - Parameter bool: The boolean value to convert.
        init(_ bool: Bool)
    }
}

// MARK: - Bool Conformance

extension Bool: Logic.`Protocol` {
    // Swift's Bool already has `true` and `false` as language-level constructs.
    // We construct them from comparisons to avoid keyword conflicts.

    /// The true value of Boolean logic.
    @inlinable
    public static var `true`: Bool { 1 == 1 }

    /// The false value of Boolean logic.
    @inlinable
    public static var `false`: Bool { 1 == 0 }

    /// Returns the Boolean's truth value, which is never `nil`.
    @inlinable
    public static func from(_ value: Bool) -> Bool? {
        value
    }

    /// Creates a Boolean from the given Boolean value.
    @inlinable
    public init(_ bool: Bool) {
        self = bool
    }
}
