//
//  ||.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 02-05-2024.
//

import Foundation

/// Custom infix operator for logical OR of two optional Boolean values.
///
/// The `||` operator performs a logical OR operation on two optional Boolean values.
/// If either value is `nil`, the result is `nil`. Otherwise, it returns the logical OR of the two values.
///
/// - Parameters:
///   - lhs: An optional Boolean value.
///   - rhs: An autoclosure that returns an optional Boolean value. This closure is evaluated lazily and can throw an error.
/// - Returns: An optional Boolean value that is the logical OR of the two input values, or `nil` if either input is `nil`.
/// - Throws: Rethrows any error thrown by the autoclosure.
///
/// The `||` operator can be used to safely perform a logical OR operation on optional Boolean values, taking advantage of lazy evaluation and error handling.
///
/// - Example:
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = false
/// let c: Bool? = nil
///
/// do {
///     print(try a || b) // Prints "Optional(true)"
///     print(try a || c) // Prints "Optional(true)"
///     print(try b || c) // Prints "nil"
///     print(try b || b) // Prints "Optional(false)"
///     print(try c || c) // Prints "nil"
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
///     print(try a || throwingValue()) // Will throw an error
/// } catch {
///     print("An error occurred: \(error)") // Prints "An error occurred: intentionalError"
/// }
/// ```
public func || (
    lhs: Bool?,
    rhs: @autoclosure () throws -> Bool?
) rethrows -> Bool? {
    if lhs == true {
        return true
    }

    let rhs = try rhs()

    if rhs == true {
        return true
    }
    if lhs == nil || (rhs == nil) {
        return nil
    }
    return false
}
