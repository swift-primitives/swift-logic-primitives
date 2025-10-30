//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 21/07/2024.
//

import Foundation
import OptionalLogic
import PredicateLogic

/// Custom prefix operator for logical negation of an optional closure returning a Boolean value.
///
/// The `!` operator performs a logical NOT operation on an optional closure that takes a single argument and returns a Boolean value.
/// If the closure is `nil`, the result is `nil`. Otherwise, it returns a new closure that negates the result of the original closure.
///
/// - Parameter closure: An optional closure that takes a value of type `T` and returns a `Bool`.
/// - Returns: An optional closure that takes a value of type `T` and returns an optional `Bool`, or `nil` if the original closure was `nil`.
///
/// The `!` operator can be used to safely negate the result of an optional closure, preserving the optionality.
///
/// - Example:
/// ```swift
/// let isEven: (Int) -> Bool = { $0 % 2 == 0 }
/// var optionalIsEven: ((Int) -> Bool)? = isEven
/// let isOdd = !optionalIsEven
///
/// print(isOdd?(4)) // Prints "Optional(false)"
/// print(isOdd?(5)) // Prints "Optional(true)"
///
/// optionalIsEven = nil
///
/// print(isOdd?(4)) // Prints "nil"
/// print(isOdd?(5)) // Prints "nil"
/// ```
prefix public func ! <T>(
    closure: ((T) -> Bool)?
) -> ((T) -> Bool?)? {
    guard let closure = closure else {
        return nil
    }
    return { !closure($0) }
}
