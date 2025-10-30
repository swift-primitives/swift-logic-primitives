//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 21/07/2024.
//

import Foundation

/// Extension to make `Bool` conform to `CaseIterable` protocol.
///
/// This extension provides all possible cases for an Boolean value.
/// The possible cases are: `true`, `false`, and `nil`.
extension Bool: /*@retroactive*/ CaseIterable {
    /// All possible cases for an Boolean value.
    public static let allCases: [Bool] = [true, false]
}

/// Extension to provide all possible cases for an array of tuples containing two Boolean values.
extension [(Bool)] {
    /// All possible cases for an array containing tuples of two Boolean values.
    public static let allCases: Self = Bool.allCases
}

/// Extension to provide all possible cases for an array of tuples containing two Boolean values.
extension [(Bool, Bool)] {
    /// All possible cases for an array containing tuples of two Boolean values.
    public static let allCases: Self = Bool.allCases.flatMap { first in
        Bool.allCases.map { second in
            (first, second)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing three Boolean values.
extension [(Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of three Boolean values.
    public static let allCases: Self = [(Bool, Bool)].allCases.flatMap { (first, second) in
        Bool.allCases.map { third in
            (first, second, third)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing four Boolean values.
extension [(Bool, Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of four Boolean values.
    public static let allCases: Self = [(Bool, Bool, Bool)].allCases.flatMap { (first, second, third) in
        Bool.allCases.map { fourth in
            (first, second, third, fourth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing five Boolean values.
extension [(Bool, Bool, Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of five Boolean values.
    public static let allCases: Self = [(Bool, Bool, Bool, Bool)].allCases.flatMap { (first, second, third, fourth) in
        Bool.allCases.map { fifth in
            (first, second, third, fourth, fifth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing six Boolean values.
extension [(Bool, Bool, Bool, Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of six Boolean values.
    public static let allCases: Self = [(Bool, Bool, Bool, Bool, Bool)].allCases.flatMap { (first, second, third, fourth, fifth) in
        Bool.allCases.map { sixth in
            (first, second, third, fourth, fifth, sixth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing seven Boolean values.
extension [(Bool, Bool, Bool, Bool, Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of seven Boolean values.
    public static let allCases: Self = [(Bool, Bool, Bool, Bool, Bool, Bool)].allCases.flatMap { (first, second, third, fourth, fifth, sixth) in
        Bool.allCases.map { seventh in
            (first, second, third, fourth, fifth, sixth, seventh)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing eight Boolean values.
extension [(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of eight Boolean values.
    public static let allCases: Self = [(Bool, Bool, Bool, Bool, Bool, Bool, Bool)].allCases.flatMap { (first, second, third, fourth, fifth, sixth, seventh) in
        Bool.allCases.map { eighth in
            (first, second, third, fourth, fifth, sixth, seventh, eighth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing nine Boolean values
extension [(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of nine Boolean values.
    public static let allCases: Self = [(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)].allCases.flatMap { (first, second, third, fourth, fifth, sixth, seventh, eighth) in
        Bool.allCases.map { ninth in
            (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth)
        }
    }
}

/// Extension to provide all possible cases for an array of tuples containing ten Boolean values.
extension [(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)] {
    /// All possible cases for an array containing tuples of ten Boolean values.
    public static let allCases: Self = [(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)].allCases.flatMap { (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth) in
        Bool.allCases.map { tenth in
            (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth)
        }
    }
}
