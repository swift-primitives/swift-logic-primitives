//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 21/07/2024.
//

import Foundation

/// Custom infix operator for logical XOR of two Boolean values.
///
/// The `^` operator performs a logical XOR operation on two Boolean values.
/// It returns `true` if exactly one of the values is `true`, and `false` otherwise.
///
/// - Parameters:
///   - lhs: A Boolean value.
///   - rhs: A Boolean value.
/// - Returns: A Boolean value that is the XOR of the two input values.
///
/// - Example:
/// ```swift
/// let a: Bool = true
/// let b: Bool = false
///
/// print(a ^ b) // Prints "true"
/// print(a ^ a) // Prints "false"
/// print(b ^ b) // Prints "false"
/// ```
public func ^ (
    lhs: Bool,
    rhs: Bool
) -> Bool {
    return lhs != rhs
}
