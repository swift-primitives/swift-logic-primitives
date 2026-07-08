// MARK: - Ternary Namespace

extension Logic {
    /// Namespace for ternary (three-valued) logic types and operations.
    ///
    /// Ternary logic extends classical boolean logic with a third value representing "unknown" or "indeterminate". Use this to handle computations where truth values may not be fully determined, such as database null handling, partial evaluations, or SQL-like three-valued logic.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let a: Bool? = true
    /// let b: Bool? = nil  // unknown
    /// let result = a && b
    /// // result = nil (unknown, because b is unknown)
    /// ```
    public enum Ternary {}
}

// MARK: - Protocol

extension Logic.Ternary {
    /// A type that represents three-valued (ternary) logic.
    ///
    /// Ternary logic extends classical boolean logic with a third value representing "unknown" or "indeterminate". Conforming types gain all Strong Kleene logic operators (`&&`, `||`, `!`, `^`, `!&&`, `!||`, `!^`) through protocol extensions, enabling SQL-like three-valued reasoning.
    ///
    /// This protocol extends `Logic.Protocol` by adding the `unknown` value and
    /// requiring an initializer that accepts `Bool?`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// enum Tribool: Logic.Ternary.Protocol {
    ///     case yes, no, maybe
    ///
    ///     static var `true`: Tribool { .yes }
    ///     static var `false`: Tribool { .no }
    ///     static var unknown: Tribool { .maybe }
    ///
    ///     static func from(_ value: Tribool) -> Bool? {
    ///         switch value {
    ///         case .yes: true
    ///         case .no: false
    ///         case .maybe: nil
    ///         }
    ///     }
    ///
    ///     init(_ bool: Bool?) {
    ///         switch bool {
    ///         case true: self = .yes
    ///         case false: self = .no
    ///         case nil: self = .maybe
    ///         }
    ///     }
    ///
    ///     init(_ bool: Bool) {
    ///         self.init(bool as Bool?)
    ///     }
    /// }
    ///
    /// let a = Tribool.yes
    /// let b = Tribool.maybe
    /// let result = a && b
    /// // result = .maybe (unknown)
    /// ```
    public protocol `Protocol`: Logic.`Protocol` {
        /// The unknown/indeterminate value.
        static var unknown: Self { get }

        /// Creates a ternary value from an optional Bool.
        ///
        /// - Parameter bool: `true`, `false`, or `nil` for unknown.
        init(_ bool: Bool?)
    }
}

// MARK: - Internal Truth Tables

extension Logic.Ternary {
    @inlinable @inline(always)
    package static func _and<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isFalse { return .false }
        if T.from(rhs).isFalse { return .false }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .true
    }

    @inlinable @inline(always)
    package static func _or<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isTrue { return .true }
        if T.from(rhs).isTrue { return .true }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .false
    }

    @inlinable @inline(always)
    package static func _nand<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isFalse { return .true }
        if T.from(rhs).isFalse { return .true }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .false
    }

    @inlinable @inline(always)
    package static func _nor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isTrue { return .false }
        if T.from(rhs).isTrue { return .false }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .true
    }

    @inlinable @inline(always)
    package static func _implies<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        if T.from(lhs).isFalse { return .true }
        if T.from(rhs).isTrue { return .true }
        if T.from(lhs) == nil || T.from(rhs) == nil { return .unknown }
        return .false
    }
}

// MARK: - AND Operator

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic AND (static implementation).
    ///
    /// Returns `false` if either operand is `false` (short-circuits), `unknown` if either operand is `unknown` and neither is `false`, or `true` only if both operands are `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.and(true as Bool?, nil)
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func and<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isFalse { return .false }
        return _and(lhs, try rhs())
    }
}

/// Performs Strong Kleene three-valued logic AND.
///
/// Returns `false` if either operand is `false` (short-circuits), `unknown` if either operand is `unknown` and neither is `false`, or `true` only if both operands are `true`.
///
/// ## Example
///
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = nil
/// let result = a && b
/// // result = nil (unknown)
/// ```
@inlinable
public func && <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isFalse { return .false }
    return Logic.Ternary._and(lhs, try rhs())
}

// MARK: - OR Operator

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic OR (static implementation).
    ///
    /// Returns `true` if either operand is `true` (short-circuits), `unknown` if either operand is `unknown` and neither is `true`, or `false` only if both operands are `false`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.or(false as Bool?, nil)
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func or<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isTrue { return .true }
        return _or(lhs, try rhs())
    }
}

/// Performs Strong Kleene three-valued logic OR.
///
/// Returns `true` if either operand is `true` (short-circuits), `unknown` if either operand is `unknown` and neither is `true`, or `false` only if both operands are `false`.
///
/// ## Example
///
/// ```swift
/// let a: Bool? = false
/// let b: Bool? = nil
/// let result = a || b
/// // result = nil (unknown)
/// ```
@inlinable
public func || <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isTrue { return .true }
    return Logic.Ternary._or(lhs, try rhs())
}

// MARK: - NOT Operator

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic NOT (static implementation).
    ///
    /// Returns `unknown` if the operand is `unknown`, otherwise returns the logical negation.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.not(nil as Bool?)
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func not<T: `Protocol`>(_ value: T) -> T {
        switch T.from(value) {
        case true: return .false
        case false: return .true
        case nil: return .unknown
        }
    }
}

/// Performs Strong Kleene three-valued logic NOT.
///
/// Returns `unknown` if the operand is `unknown`, otherwise returns the logical negation.
///
/// ## Example
///
/// ```swift
/// let a: Bool? = nil
/// let result = !a
/// // result = nil (unknown)
/// ```
@inlinable
public prefix func ! <T: Logic.Ternary.`Protocol`>(value: T) -> T {
    Logic.Ternary.not(value)
}

// MARK: - XOR Operator

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic XOR (exclusive OR) (static implementation).
    ///
    /// Returns `unknown` if either operand is `unknown`, otherwise returns `true` if exactly one operand is `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.xor(true as Bool?, nil)
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func xor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs), let r = T.from(rhs) else { return .unknown }
        return l != r ? .true : .false
    }
}

/// Performs Strong Kleene three-valued logic XOR (exclusive OR).
///
/// Returns `unknown` if either operand is `unknown`, otherwise returns `true` if exactly one operand is `true`.
///
/// ## Example
///
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = nil
/// let result = a ^ b
/// // result = nil (unknown)
/// ```
@inlinable
public func ^ <T: Logic.Ternary.`Protocol`>(lhs: T, rhs: T) -> T {
    Logic.Ternary.xor(lhs, rhs)
}

// MARK: - NAND Operator

// Custom infix operator for NAND
infix operator !&& : LogicalConjunctionPrecedence

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic NAND (NOT AND) (static implementation).
    ///
    /// Returns the negation of the AND result.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.nand(true as Bool?, true)
    /// // result = false (negation of true AND true)
    /// ```
    @inlinable
    public static func nand<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isFalse { return .true }
        return _nand(lhs, try rhs())
    }
}

/// Performs Strong Kleene three-valued logic NAND (NOT AND).
///
/// Returns the negation of the AND result.
///
/// ## Example
///
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = true
/// let result = a !&& b
/// // result = false (negation of true AND true)
/// ```
@inlinable
public func !&& <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isFalse { return .true }
    return Logic.Ternary._nand(lhs, try rhs())
}

// MARK: - NOR Operator

// Custom infix operator for NOR
infix operator !|| : LogicalDisjunctionPrecedence

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic NOR (NOT OR) (static implementation).
    ///
    /// Returns the negation of the OR result.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.nor(false as Bool?, false)
    /// // result = true (negation of false OR false)
    /// ```
    @inlinable
    public static func nor<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isTrue { return .false }
        return _nor(lhs, try rhs())
    }
}

/// Performs Strong Kleene three-valued logic NOR (NOT OR).
///
/// Returns the negation of the OR result.
///
/// ## Example
///
/// ```swift
/// let a: Bool? = false
/// let b: Bool? = false
/// let result = a !|| b
/// // result = true (negation of false OR false)
/// ```
@inlinable
public func !|| <E: Swift.Error, T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () throws(E) -> T
) throws(E) -> T {
    if T.from(lhs).isTrue { return .false }
    return Logic.Ternary._nor(lhs, try rhs())
}

// MARK: - Implication

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic implication (material conditional) (static implementation).
    ///
    /// `implies(a, b)` is `!a || b`: returns `true` if `lhs` is `false` (vacuous truth, short-circuits) or `rhs` is `true`, `false` only when `lhs` is `true` and `rhs` is `false`, and `unknown` otherwise.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.implies(nil as Bool?, true)
    /// // result = true (x → true is true even when x is unknown)
    /// ```
    @inlinable
    public static func implies<E: Swift.Error, T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () throws(E) -> T
    ) throws(E) -> T {
        if T.from(lhs).isFalse { return .true }
        return _implies(lhs, try rhs())
    }
}

// MARK: - Biconditional

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic biconditional (if and only if) (static implementation).
    ///
    /// Returns `unknown` if either operand is `unknown`, otherwise returns `true` if both operands have the same value. This is equivalent to XNOR.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.iff(true as Bool?, true)
    /// // result = true (both are true)
    /// ```
    @inlinable
    public static func iff<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        xnor(lhs, rhs)
    }
}

// MARK: - XNOR Operator

// Custom infix operator for XNOR
infix operator !^ : ComparisonPrecedence

extension Logic.Ternary {
    /// Performs Strong Kleene three-valued logic XNOR (equivalence) (static implementation).
    ///
    /// Returns `unknown` if either operand is `unknown`, otherwise returns `true` if both operands have the same value.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.xnor(true as Bool?, true)
    /// // result = true (both are true)
    /// ```
    @inlinable
    public static func xnor<T: `Protocol`>(_ lhs: T, _ rhs: T) -> T {
        guard let l = T.from(lhs), let r = T.from(rhs) else { return .unknown }
        return l == r ? .true : .false
    }
}

/// Performs Strong Kleene three-valued logic XNOR (equivalence).
///
/// Returns `unknown` if either operand is `unknown`, otherwise returns `true` if both operands have the same value.
///
/// ## Example
///
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = true
/// let result = a !^ b
/// // result = true (both are true)
/// ```
@inlinable
public func !^ <T: Logic.Ternary.`Protocol`>(lhs: T, rhs: T) -> T {
    Logic.Ternary.xnor(lhs, rhs)
}
