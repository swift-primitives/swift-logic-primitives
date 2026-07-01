// swiftlint:disable:next workaround_marker_present
// WORKAROUND: Non-throwing overloads shadow the typed-throws ternary operators so the
// `&&`/`||`/`!&&`/`!||` forms type-check on non-throwing operands.
// WHY: The compiler cannot infer the thrown-error type as `Never` for a typed-throws
// `@autoclosure () throws(E) -> T` parameter at a non-throwing call site.
// WHEN TO REMOVE: When the compiler infers `E == Never` for such parameters.
// TRACKING: https://github.com/swiftlang/swift/issues/86596

// MARK: - Non-Throwing Operators

/// Non-throwing overload for Strong Kleene three-valued logic AND.
@inlinable
public func && <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    Logic.Ternary._and(lhs, rhs())
}

/// Non-throwing overload for Strong Kleene three-valued logic OR.
@inlinable
public func || <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    Logic.Ternary._or(lhs, rhs())
}

/// Non-throwing overload for Strong Kleene three-valued logic NAND.
@inlinable
public func !&& <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    Logic.Ternary._nand(lhs, rhs())
}

/// Non-throwing overload for Strong Kleene three-valued logic NOR.
@inlinable
public func !|| <T: Logic.Ternary.`Protocol`>(
    lhs: T,
    rhs: @autoclosure () -> T
) -> T {
    Logic.Ternary._nor(lhs, rhs())
}

// MARK: - Non-Throwing Static Methods

extension Logic.Ternary {
    /// Non-throwing overload for Strong Kleene AND.
    @inlinable
    public static func and<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        _and(lhs, rhs())
    }

    /// Non-throwing overload for Strong Kleene OR.
    @inlinable
    public static func or<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        _or(lhs, rhs())
    }

    /// Non-throwing overload for Strong Kleene NAND.
    @inlinable
    public static func nand<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        _nand(lhs, rhs())
    }

    /// Non-throwing overload for Strong Kleene NOR.
    @inlinable
    public static func nor<T: `Protocol`>(
        _ lhs: T,
        _ rhs: @autoclosure () -> T
    ) -> T {
        _nor(lhs, rhs())
    }
}
