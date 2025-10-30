//
//  File.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 19/07/2024.
//

import Foundation
import LogicOperators
import LogicTesting
import OptionalLogic
import PredicateLogic
import Testing

@Test("^", arguments: Bool.allCases, Bool.allCases)
func xorTest(lhs: Bool, rhs: Bool) {
    #expect((lhs ^ rhs) == (lhs != rhs))
}

@Test("!")
func negateOptionalClosureTest() {
    let closures: [((Int) -> Bool)?] = [
        .some({ $0 % 2 == 0 }),
        .none
    ]

    for optionalIsEven in closures {
        switch optionalIsEven {
        case let .some(isEven):
            #expect(!optionalIsEven?(4) == !isEven(4))
        case .none:
            let isOdd = !optionalIsEven
            #expect(isOdd?(4) == nil)
            #expect(isOdd?(5) == nil)
        }
    }
}

@Test("^", arguments: Bool?.allCases, Bool?.allCases)
func xorTest(left: Bool?, right: Bool?) {
    switch (left, right) {
    case (.none, _):
        #expect((left ^ right) == .none)
    case (_, .none):
        #expect((left ^ right) == .none)
    case (.some(let l), .some(let r)):
        #expect((left ^ right) == (l ^ r))
    }
}
