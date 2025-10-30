//
//  File.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 08/07/2024.
//

import Foundation

/// Extension to make `Bool?` conform to `CaseIterable` protocol.
///
/// This extension provides all possible cases for an optional Boolean value.
/// The possible cases are: `true`, `false`, and `nil`.
extension Bool?: /*@retroactive*/ CaseIterable {
    /// All possible cases for an optional Boolean value.
    public static let allCases: [Optional<Bool>] = [.some(true), .some(false), .none]
}

/// Extension to provide all possible cases for an array of optional Boolean values.
extension [Bool?] {
    /// All possible cases for an array containing a single optional Boolean value.
    public static let allCases: Self = Bool?.allCases
}

/// Extension to provide all possible cases for an array of tuples containing two optional Boolean values.
extension [(Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of two optional Boolean values.
    public static let allCases: Self = Bool?.allCases.flatMap { first in
        Bool?.allCases.map { second in
            (first, second)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing three optional Boolean values.
extension [(Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of three optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?)].allCases.flatMap { (first, second) in
        Bool?.allCases.map { third in
            (first, second, third)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing four optional Boolean values.
extension [(Bool?, Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of four optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?, Bool?)].allCases.flatMap { (first, second, third) in
        Bool?.allCases.map { fourth in
            (first, second, third, fourth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing five optional Boolean values.
extension [(Bool?, Bool?, Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of five optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?, Bool?, Bool?)].allCases.flatMap { (first, second, third, fourth) in
        Bool?.allCases.map { fifth in
            (first, second, third, fourth, fifth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing six optional Boolean values.
extension [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of six optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.flatMap { (first, second, third, fourth, fifth) in
        Bool?.allCases.map { sixth in
            (first, second, third, fourth, fifth, sixth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing seven optional Boolean values.
extension [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of seven optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.flatMap { (first, second, third, fourth, fifth, sixth) in
        Bool?.allCases.map { seventh in
            (first, second, third, fourth, fifth, sixth, seventh)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing eight optional Boolean values.
extension [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of eight optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.flatMap { (first, second, third, fourth, fifth, sixth, seventh) in
        Bool?.allCases.map { eighth in
            (first, second, third, fourth, fifth, sixth, seventh, eighth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing nine optional Boolean values
extension [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of nine optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.flatMap { (first, second, third, fourth, fifth, sixth, seventh, eighth) in
        Bool?.allCases.map { ninth in
            (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing ten optional Boolean values.
extension [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)] {
    /// All possible cases for an array containing tuples of ten optional Boolean values.
    public static let allCases: Self = [(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.flatMap { (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth) in
        Bool?.allCases.map { tenth in
            (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth)
        }
    }
}
