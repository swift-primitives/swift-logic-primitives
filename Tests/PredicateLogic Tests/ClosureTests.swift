//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 21/07/2024.
//

import Foundation
import LogicTesting
import PredicateLogic
import Testing

@Test("!", arguments: Bool.allCases)
func notThrowsClosureTest(value: Bool) throws {
    let closure: (Bool) throws -> Bool = { $0 }

    let notClosure = !closure

    #expect(try notClosure(value) == !value)
}

@Test("!", arguments: Bool.allCases)
func testNonThrowingClosure(value: Bool) {
    let closure: (Bool) -> Bool = { $0 }
    let negatedClosure = !closure

    #expect(negatedClosure(value) == !value)
}

@Test("!=", arguments: [(Bool, Bool)].allCases)
func notEqualsClosureTest(pair: (Bool, Bool)) {
    let (lhs, rhs) = pair
    let lhsClosure: (Bool) -> Bool = { _ in lhs }
    let rhsClosure: (Bool) -> Bool = { _ in rhs }

    let notEqualsClosure = lhsClosure != rhsClosure

    #expect(notEqualsClosure(true) == (lhs != rhs))
    #expect(notEqualsClosure(false) == (lhs != rhs))
}

@Test("&&", arguments: [(Bool, Bool)].allCases)
func andClosureTest(pair: (Bool, Bool)) {
    let (lhs, rhs) = pair
    let lhsClosure: (Bool) -> Bool = { _ in lhs }
    let rhsClosure: (Bool) -> Bool = { _ in rhs }

    let andClosure = lhsClosure && rhsClosure

    #expect(andClosure(true) == (lhs && rhs))
    #expect(andClosure(false) == (lhs && rhs))
}

@Test("^", arguments: [(Bool, Bool)].allCases)
func xorClosureTest(pair: (Bool, Bool)) {
    let (lhs, rhs) = pair
    let lhsClosure: (Bool) -> Bool = { _ in lhs }
    let rhsClosure: (Bool) -> Bool = { _ in rhs }

    let xorClosure = lhsClosure ^ rhsClosure

    #expect(xorClosure(true) == (lhs != rhs))
    #expect(xorClosure(false) == (lhs != rhs))
}

@Test("==", arguments: [(Bool, Bool)].allCases)
func equalsClosureTest(pair: (Bool, Bool)) {
    let (lhs, rhs) = pair
    let lhsClosure: (Bool) -> Bool = { _ in lhs }
    let rhsClosure: (Bool) -> Bool = { _ in rhs }

    let equalsClosure = lhsClosure == rhsClosure

    #expect(equalsClosure(true) == (lhs == rhs))
    #expect(equalsClosure(false) == (lhs == rhs))
}

@Test("||", arguments: [(Bool, Bool)].allCases)
func orClosureTest(pair: (Bool, Bool)) {
    let (lhs, rhs) = pair
    let lhsClosure: (Bool) -> Bool = { _ in lhs }
    let rhsClosure: (Bool) -> Bool = { _ in rhs }

    let orClosure = lhsClosure || rhsClosure

    #expect(orClosure(true) == (lhs || rhs))
    #expect(orClosure(false) == (lhs || rhs))
}
