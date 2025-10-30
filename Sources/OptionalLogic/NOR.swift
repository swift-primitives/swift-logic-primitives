//
//  !||.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 19/07/2024.
//

import Foundation

// NOR (!||) Operator for Optional Booleans
infix operator !||: LogicalDisjunctionPrecedence

/// Custom infix operator for logical NOR (NOT OR) of two optional Boolean values.
///
/// The `!||` operator performs a logical NOR operation on two optional Boolean values.
/// If either value is `nil`, the result is `nil`. Otherwise, it returns the logical NOR (NOT OR) of the two values.
///
/// - Parameters:
///   - lhs: An optional Boolean value.
///   - rhs: An autoclosure that returns an optional Boolean value. This closure is evaluated lazily and can throw an error.
/// - Returns: An optional Boolean value that is the NOR of the two input values, or `nil` if either input is `nil`.
/// - Throws: Rethrows any error thrown by the autoclosure.
///
/// The `!||` operator can be used to safely perform a logical NOR operation on optional Boolean values, taking advantage of lazy evaluation and error handling.
///
/// - Example:
/// ```swift
/// let a: Bool? = true
/// let b: Bool? = false
/// let c: Bool? = nil
///
/// do {
///     print(try a !|| b) // Prints "Optional(false)"
///     print(try a !|| c) // Prints "nil"
///     print(try b !|| c) // Prints "nil"
///     print(try b !|| b) // Prints "Optional(true)"
///     print(try a !|| a) // Prints "Optional(false)"
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
///     print(try a !|| throwingValue()) // Will throw an error
/// } catch {
///     print("An error occurred: \(error)") // Prints "An error occurred: intentionalError"
/// }
/// ```
public func !|| (
    lhs: Bool?,
    rhs: @autoclosure () throws -> Bool?
) rethrows -> Bool? {
    let x: Bool? = try (lhs || rhs())

    return !x
}
