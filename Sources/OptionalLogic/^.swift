//
//  ^.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 19/07/2024.
//

import Foundation

/// Custom infix operator for logical XOR of two optional Equatable values.
///
/// The `^` operator performs a logical XOR operation on two optional Equatable values.
/// If either value is `nil`, the result is `nil`. Otherwise, it returns the XOR of the two values using the `!=` operator.
///
/// - Parameters:
///   - lhs: An optional Equatable value.
///   - rhs: A closure that returns an optional Equatable value.
/// - Returns: An optional Boolean value that is the XOR of the two input values, or `nil` if either input is `nil`.
///
/// - Example:
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = false
/// let c: Bool? = nil
///
/// print(a ^ b) // Prints "Optional(true)"
/// print(a ^ c) // Prints "nil"
/// print(b ^ c) // Prints "nil"
/// print(b ^ b) // Prints "Optional(false)"
/// ```
@_disfavoredOverload
public func ^<T: Equatable>(
    lhs: T?,
    rhs: @autoclosure () throws -> T?
) rethrows -> Bool? {
    guard let lhs = lhs else {
        return nil
    }

    guard let rhs = try rhs() else {
        return nil
    }
    return lhs != rhs
}
