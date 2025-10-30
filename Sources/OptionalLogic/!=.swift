//
//  !=.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 19/07/2024.
//

import Foundation

// Inequality (!=) Operator for Optional Values
// infix operator != : ComparisonPrecedence

/// Custom infix operator for logical inequality of two optional Equatable values.
///
/// The `!=` operator performs a logical inequality (not equal) operation on two optional Equatable values.
/// If either value is `nil`, the result is `nil`. Otherwise, it returns `true` if the values are not equal, and `false` if they are equal.
///
/// - Parameters:
///   - lhs: An optional Equatable value.
///   - rhs: An autoclosure that returns an optional Equatable value. This closure is evaluated lazily and can throw an error.
/// - Returns: An optional Boolean value that is `true` if the values are not equal, `false` if they are equal, or `nil` if either input is `nil`.
/// - Throws: Rethrows any error thrown by the autoclosure.
///
/// The `!=` operator can be used to safely compare optional Equatable values for inequality, taking advantage of lazy evaluation and error handling.
///
/// - Example:
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = false
/// let c: Bool? = nil
///
/// do {
///     print(try a != b) // Prints "Optional(true)"
///     print(try a != c) // Prints "nil"
///     print(try b != c) // Prints "nil"
///     print(try b != b) // Prints "Optional(false)"
/// } catch {
///     print("An error occurred: \(error)")
/// }
///
/// // Example with a throwing autoclosure
/// enum TestError: Error {
///     case intentionalError
/// }
///
/// let throwingValue: () throws -> Bool? = { throw TestError.intentionalError }
///
/// do {
///     print(try a != throwingValue()) // Will throw an error
/// } catch {
///     print("An error occurred: \(error)") // Prints "An error occurred: intentionalError"
/// }
/// ```
// public func !=<T: Equatable>(
//    lhs: T?,
//    rhs: @autoclosure () throws -> T?
// ) rethrows -> Bool {
//
//    let rhsValue = try rhs()
//    
//    switch (lhs, rhsValue) {
//    case let (l?, r?):
//        return l != r
//    case (nil, nil):
//        return false
//    default:
//        return true
//    }
// }

public func !=<T: Equatable>(
    lhs: T?,
    rhs: @autoclosure () throws -> T?
) rethrows -> Bool {
    let rhsValue = try rhs()

    if let lhsValue = lhs, let rhsValue = rhsValue {
        return lhsValue != rhsValue
    }
    return (lhs != nil) != (rhsValue != nil)
}
