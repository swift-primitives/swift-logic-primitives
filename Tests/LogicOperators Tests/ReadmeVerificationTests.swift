//
//  ReadmeVerificationTests.swift
//  swift-logic-operators
//
//  Created to validate README code examples compile and work correctly.
//

import Testing
@testable import LogicOperators

@Suite("README Verification")
struct ReadmeVerificationTests {

    // MARK: - Quick Start Examples (lines 45-60)

    @Test("Quick Start - Optional Boolean operations")
    func quickStartOptionalBooleans() throws {
        // Optional Boolean operations
        let a: Bool? = true
        let b: Bool? = nil
        let result = a && b  // nil

        #expect(result == nil)
    }

    @Test("Quick Start - Predicate composition")
    func quickStartPredicateComposition() throws {
        // Predicate composition
        let isEven: (Int) -> Bool = { $0 % 2 == 0 }
        let isPositive: (Int) -> Bool = { $0 > 0 }
        let isEvenAndPositive = isEven && isPositive

        #expect(isEvenAndPositive(4) == true)
        #expect(isEvenAndPositive(-4) == false)
    }

    // MARK: - Optional Boolean Operators (lines 69-104)

    @Test("Optional Boolean operators - comprehensive")
    func optionalBooleanOperators() throws {
        let t: Bool? = true
        let f: Bool? = false
        let n: Bool? = nil

        // NOT
        #expect(!t == false)
        #expect(!f == true)
        #expect(!n == nil)

        // AND
        #expect((t && f) == false)
        #expect((t && n) == nil)
        #expect((f && n) == nil)

        // OR
        #expect((t || f) == true)
        #expect((t || n) == true)
        #expect((f || n) == nil)

        // XOR
        #expect((t ^ f) == true)
        #expect((t ^ n) == nil)
        #expect((f ^ f) == false)

        // NAND
        #expect((t !&& f) == true)
        #expect((t !&& t) == false)

        // NOR
        #expect((t !|| f) == false)
        #expect((f !|| f) == true)

        // XNOR
        #expect((t !^ f) == false)
        #expect((t !^ t) == true)
    }

    // MARK: - Predicate Composition (lines 110-146)

    @Test("Predicate AND operator")
    func predicateAndOperator() throws {
        let isEven: (Int) -> Bool = { $0 % 2 == 0 }
        let isPositive: (Int) -> Bool = { $0 > 0 }

        // AND
        let isEvenAndPositive = isEven && isPositive
        #expect(isEvenAndPositive(4) == true)
        #expect(isEvenAndPositive(-4) == false)
    }

    @Test("Predicate OR operator")
    func predicateOrOperator() throws {
        let isEven: (Int) -> Bool = { $0 % 2 == 0 }
        let isNegative: (Int) -> Bool = { $0 < 0 }

        // OR
        let isEvenOrNegative = isEven || isNegative
        #expect(isEvenOrNegative(3) == false)
        #expect(isEvenOrNegative(-3) == true)
    }

    @Test("Predicate NOT operator")
    func predicateNotOperator() throws {
        let isEven: (Int) -> Bool = { $0 % 2 == 0 }

        // NOT
        let isOdd = !isEven
        #expect(isOdd(5) == true)
        #expect(isOdd(4) == false)
    }

    @Test("Predicate XOR operator")
    func predicateXorOperator() throws {
        let isEven: (Int) -> Bool = { $0 % 2 == 0 }
        let isPositive: (Int) -> Bool = { $0 > 0 }

        // XOR
        let isEvenXorPositive = isEven ^ isPositive
        #expect(isEvenXorPositive(4) == false)  // both true
        #expect(isEvenXorPositive(-4) == true)  // even but not positive
        #expect(isEvenXorPositive(3) == true)   // positive but not even
        #expect(isEvenXorPositive(-3) == false) // neither
    }

    @Test("Predicate Equality operator")
    func predicateEqualityOperator() throws {
        let isEven: (Int) -> Bool = { $0 % 2 == 0 }
        let isPositive: (Int) -> Bool = { $0 > 0 }

        // Equality
        let same = isEven == isPositive
        #expect(same(4) == true)   // both predicates return true for 4
        #expect(same(-4) == false) // isEven true, isPositive false
        #expect(same(3) == false)  // isEven false, isPositive true
        #expect(same(-3) == true)  // both predicates return false for -3
    }

    @Test("Predicate Inequality operator")
    func predicateInequalityOperator() throws {
        let isEven: (Int) -> Bool = { $0 % 2 == 0 }
        let isPositive: (Int) -> Bool = { $0 > 0 }

        // Inequality
        let different = isEven != isPositive
        #expect(different(4) == false)  // both predicates return true
        #expect(different(-4) == true)  // different results
        #expect(different(3) == true)   // different results
        #expect(different(-3) == false) // both predicates return false
    }
}
