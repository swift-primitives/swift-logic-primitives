// TernaryLogic Tests.swift
// Tests for Strong Kleene three-valued logic.

import Testing

@testable import Logic_Ternary_Primitives

// MARK: - Test Cases

/// Represents a binary logic test case with optional Bool values.
struct BinaryTestCase: CustomTestStringConvertible, Sendable {
    let lhs: Bool?
    let rhs: Bool?
    let expected: Bool?

    var testDescription: String {
        "\(lhs.map(String.init(describing:)) ?? "nil") → \(rhs.map(String.init(describing:)) ?? "nil") = \(expected.map(String.init(describing:)) ?? "nil")"
    }
}

/// Represents a unary logic test case.
struct UnaryTestCase: CustomTestStringConvertible, Sendable {
    let input: Bool?
    let expected: Bool?

    var testDescription: String {
        "\(input.map(String.init(describing:)) ?? "nil") → \(expected.map(String.init(describing:)) ?? "nil")"
    }
}

// MARK: - NOT Tests

@Suite
struct ThreeValuedLogicNOTTests {
    static let notCases: [UnaryTestCase] = [
        .init(input: true, expected: false),
        .init(input: false, expected: true),
        .init(input: nil, expected: nil),
    ]

    @Test(arguments: notCases)
    func not(_ testCase: UnaryTestCase) {
        #expect((!testCase.input) == testCase.expected)
    }

    @Test(arguments: [true, false])
    func involution(_ value: Bool) {
        #expect((!(!value)) == value)
    }
}

// MARK: - AND Tests

@Suite
struct ThreeValuedLogicANDTests {
    static let andCases: [BinaryTestCase] = [
        // Known values
        .init(lhs: false, rhs: false, expected: false),
        .init(lhs: false, rhs: true, expected: false),
        .init(lhs: true, rhs: false, expected: false),
        .init(lhs: true, rhs: true, expected: true),
        // False dominates unknown
        .init(lhs: false, rhs: nil, expected: false),
        .init(lhs: nil, rhs: false, expected: false),
        // Nil propagation
        .init(lhs: true, rhs: nil, expected: nil),
        .init(lhs: nil, rhs: true, expected: nil),
        .init(lhs: nil, rhs: nil, expected: nil),
    ]

    @Test(arguments: andCases)
    func and(_ testCase: BinaryTestCase) {
        let result = Logic.Ternary.and(testCase.lhs, testCase.rhs)
        #expect(result == testCase.expected)
    }

    @Test(arguments: andCases)
    func andOperator(_ testCase: BinaryTestCase) {
        let result: Bool? = testCase.lhs && testCase.rhs
        #expect(result == testCase.expected)
    }
}

// MARK: - OR Tests

@Suite
struct ThreeValuedLogicORTests {
    static let orCases: [BinaryTestCase] = [
        // Known values
        .init(lhs: false, rhs: false, expected: false),
        .init(lhs: false, rhs: true, expected: true),
        .init(lhs: true, rhs: false, expected: true),
        .init(lhs: true, rhs: true, expected: true),
        // True dominates unknown
        .init(lhs: true, rhs: nil, expected: true),
        .init(lhs: nil, rhs: true, expected: true),
        // Nil propagation
        .init(lhs: false, rhs: nil, expected: nil),
        .init(lhs: nil, rhs: false, expected: nil),
        .init(lhs: nil, rhs: nil, expected: nil),
    ]

    @Test(arguments: orCases)
    func or(_ testCase: BinaryTestCase) {
        let result = Logic.Ternary.or(testCase.lhs, testCase.rhs)
        #expect(result == testCase.expected)
    }

    @Test(arguments: orCases)
    func orOperator(_ testCase: BinaryTestCase) {
        let result: Bool? = testCase.lhs || testCase.rhs
        #expect(result == testCase.expected)
    }
}

// MARK: - XOR Tests

@Suite
struct ThreeValuedLogicXORTests {
    static let xorCases: [BinaryTestCase] = [
        // Known values
        .init(lhs: false, rhs: false, expected: false),
        .init(lhs: false, rhs: true, expected: true),
        .init(lhs: true, rhs: false, expected: true),
        .init(lhs: true, rhs: true, expected: false),
        // Nil always propagates
        .init(lhs: false, rhs: nil, expected: nil),
        .init(lhs: true, rhs: nil, expected: nil),
        .init(lhs: nil, rhs: false, expected: nil),
        .init(lhs: nil, rhs: true, expected: nil),
        .init(lhs: nil, rhs: nil, expected: nil),
    ]

    @Test(arguments: xorCases)
    func xor(_ testCase: BinaryTestCase) {
        #expect((testCase.lhs ^ testCase.rhs) == testCase.expected)
    }
}

// MARK: - XNOR Tests

@Suite
struct ThreeValuedLogicXNORTests {
    static let xnorCases: [BinaryTestCase] = [
        // Known values
        .init(lhs: false, rhs: false, expected: true),
        .init(lhs: false, rhs: true, expected: false),
        .init(lhs: true, rhs: false, expected: false),
        .init(lhs: true, rhs: true, expected: true),
        // Nil always propagates
        .init(lhs: false, rhs: nil, expected: nil),
        .init(lhs: true, rhs: nil, expected: nil),
        .init(lhs: nil, rhs: false, expected: nil),
        .init(lhs: nil, rhs: true, expected: nil),
        .init(lhs: nil, rhs: nil, expected: nil),
    ]

    @Test(arguments: xnorCases)
    func xnor(_ testCase: BinaryTestCase) {
        #expect((testCase.lhs !^ testCase.rhs) == testCase.expected)
    }

    @Test(arguments: xnorCases)
    func iff(_ testCase: BinaryTestCase) {
        // Biconditional is equivalence: same table as XNOR.
        #expect(Logic.Ternary.iff(testCase.lhs, testCase.rhs) == testCase.expected)
    }
}

// MARK: - NAND Tests

@Suite
struct ThreeValuedLogicNANDTests {
    static let nandCases: [BinaryTestCase] = [
        // Known values
        .init(lhs: false, rhs: false, expected: true),
        .init(lhs: false, rhs: true, expected: true),
        .init(lhs: true, rhs: false, expected: true),
        .init(lhs: true, rhs: true, expected: false),
        // NAND(false, nil) = NOT(AND(false, nil)) = NOT(false) = true
        .init(lhs: false, rhs: nil, expected: true),
        .init(lhs: nil, rhs: false, expected: true),
        // NAND(true, nil) = NOT(AND(true, nil)) = NOT(nil) = nil
        .init(lhs: true, rhs: nil, expected: nil),
        .init(lhs: nil, rhs: true, expected: nil),
        .init(lhs: nil, rhs: nil, expected: nil),
    ]

    @Test(arguments: nandCases)
    func nand(_ testCase: BinaryTestCase) {
        let result: Bool? = testCase.lhs !&& testCase.rhs
        #expect(result == testCase.expected)
    }
}

// MARK: - NOR Tests

@Suite
struct ThreeValuedLogicNORTests {
    static let norCases: [BinaryTestCase] = [
        // Known values
        .init(lhs: false, rhs: false, expected: true),
        .init(lhs: false, rhs: true, expected: false),
        .init(lhs: true, rhs: false, expected: false),
        .init(lhs: true, rhs: true, expected: false),
        // NOR(true, nil) = NOT(OR(true, nil)) = NOT(true) = false
        .init(lhs: true, rhs: nil, expected: false),
        .init(lhs: nil, rhs: true, expected: false),
        // NOR(false, nil) = NOT(OR(false, nil)) = NOT(nil) = nil
        .init(lhs: false, rhs: nil, expected: nil),
        .init(lhs: nil, rhs: false, expected: nil),
        .init(lhs: nil, rhs: nil, expected: nil),
    ]

    @Test(arguments: norCases)
    func nor(_ testCase: BinaryTestCase) {
        let result: Bool? = testCase.lhs !|| testCase.rhs
        #expect(result == testCase.expected)
    }
}

// MARK: - Implication Tests

@Suite
struct ThreeValuedLogicImplicationTests {
    static let implicationCases: [BinaryTestCase] = [
        .init(lhs: true, rhs: true, expected: true),
        .init(lhs: true, rhs: false, expected: false),
        .init(lhs: true, rhs: nil, expected: nil),
        // false → anything = true (vacuous truth)
        .init(lhs: false, rhs: true, expected: true),
        .init(lhs: false, rhs: false, expected: true),
        .init(lhs: false, rhs: nil, expected: true),
        // nil → true = true (result determined regardless of lhs)
        .init(lhs: nil, rhs: true, expected: true),
        .init(lhs: nil, rhs: false, expected: nil),
        .init(lhs: nil, rhs: nil, expected: nil),
    ]

    @Test(arguments: implicationCases)
    func implies(_ testCase: BinaryTestCase) {
        let result = Logic.Ternary.implies(testCase.lhs, testCase.rhs)
        #expect(result == testCase.expected)
    }

    /// Verifies that implication a → b matches (not a) or b.
    @Test(arguments: implicationCases)
    func matchesDisjunctiveForm(_ testCase: BinaryTestCase) {
        let result: Bool? = !testCase.lhs || testCase.rhs
        #expect(result == testCase.expected)
    }
}

// MARK: - Short-Circuit Tests

@Suite
struct ThreeValuedLogicShortCircuitTests {
    @Test
    func andShortCircuitsOnFalse() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return true
        }
        let result: Bool? = (false as Bool?) && rhs()
        #expect(result == .some(false))
        #expect(evaluated == false)
    }

    @Test
    func andEvaluatesRhsWhenUndetermined() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return true
        }
        let result: Bool? = (nil as Bool?) && rhs()
        #expect(result == nil)
        #expect(evaluated == true)
    }

    @Test
    func orShortCircuitsOnTrue() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return false
        }
        let result: Bool? = (true as Bool?) || rhs()
        #expect(result == .some(true))
        #expect(evaluated == false)
    }

    @Test
    func nandShortCircuitsOnFalse() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return true
        }
        let result: Bool? = (false as Bool?) !&& rhs()
        #expect(result == .some(true))
        #expect(evaluated == false)
    }

    @Test
    func norShortCircuitsOnTrue() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return false
        }
        let result: Bool? = (true as Bool?) !|| rhs()
        #expect(result == .some(false))
        #expect(evaluated == false)
    }

    @Test
    func impliesShortCircuitsOnFalseAntecedent() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return false
        }
        let result = Logic.Ternary.implies(false as Bool?, rhs())
        #expect(result == .some(true))
        #expect(evaluated == false)
    }

    @Test
    func staticAndShortCircuitsOnFalse() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return true
        }
        let result = Logic.Ternary.and(false as Bool?, rhs())
        #expect(result == .some(false))
        #expect(evaluated == false)
    }

    @Test
    func staticOrShortCircuitsOnTrue() {
        var evaluated = false
        func rhs() -> Bool? {
            evaluated = true
            return false
        }
        let result = Logic.Ternary.or(true as Bool?, rhs())
        #expect(result == .some(true))
        #expect(evaluated == false)
    }
}

// MARK: - De Morgan Tests

@Suite
struct ThreeValuedLogicDeMorganTests {
    static let values: [Bool?] = [true, false, nil]

    @Test(arguments: values, values)
    func deMorganAnd(_ a: Bool?, _ b: Bool?) {
        // !(a && b) == !a || !b — holds across all nine ternary pairs
        let lhs: Bool? = !(a && b)
        let rhs: Bool? = !a || !b
        #expect(lhs == rhs)
    }

    @Test(arguments: values, values)
    func deMorganOr(_ a: Bool?, _ b: Bool?) {
        // !(a || b) == !a && !b — holds across all nine ternary pairs
        let lhs: Bool? = !(a || b)
        let rhs: Bool? = !a && !b
        #expect(lhs == rhs)
    }
}

// MARK: - Base Logic Function Tests

/// The `Logic.and`/`Logic.or`/… functions on `Logic.Protocol` must degrade to
/// Strong Kleene semantics when applied to a ternary conformer such as `Bool?`
/// (regression coverage: they previously collapsed `unknown` to `false`).
@Suite
struct BaseLogicKleeneDegradationTests {
    static let values: [Bool?] = [true, false, nil]

    @Test(arguments: ThreeValuedLogicANDTests.andCases)
    func and(_ testCase: BinaryTestCase) {
        #expect(Logic.and(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicORTests.orCases)
    func or(_ testCase: BinaryTestCase) {
        #expect(Logic.or(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicNOTTests.notCases)
    func not(_ testCase: UnaryTestCase) {
        #expect(Logic.not(testCase.input) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicXORTests.xorCases)
    func xor(_ testCase: BinaryTestCase) {
        #expect(Logic.xor(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicNANDTests.nandCases)
    func nand(_ testCase: BinaryTestCase) {
        #expect(Logic.nand(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicNORTests.norCases)
    func nor(_ testCase: BinaryTestCase) {
        #expect(Logic.nor(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicXNORTests.xnorCases)
    func xnor(_ testCase: BinaryTestCase) {
        #expect(Logic.xnor(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicImplicationTests.implicationCases)
    func implies(_ testCase: BinaryTestCase) {
        #expect(Logic.implies(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    @Test(arguments: ThreeValuedLogicXNORTests.xnorCases)
    func iff(_ testCase: BinaryTestCase) {
        #expect(Logic.iff(testCase.lhs, testCase.rhs) == testCase.expected)
    }

    /// The base functions must agree with the ternary truth tables on every pair.
    @Test(arguments: values, values)
    func agreesWithTernaryOperators(_ a: Bool?, _ b: Bool?) {
        #expect(Logic.and(a, b) == (a && b))
        #expect(Logic.or(a, b) == (a || b))
        #expect(Logic.xor(a, b) == (a ^ b))
        #expect(Logic.xnor(a, b) == (a !^ b))
        #expect(Logic.nand(a, b) == (a !&& b))
        #expect(Logic.nor(a, b) == (a !|| b))
        #expect(Logic.implies(a, b) == Logic.Ternary.implies(a, b))
    }
}

// MARK: - Complex Expression Tests

@Suite
struct ThreeValuedLogicComplexExpressionTests {
    @Test
    func mixedValues() {
        let a: Bool? = true
        let b: Bool? = false
        let c: Bool? = nil

        // (true && false) || nil = false || nil = nil
        let aAndB: Bool? = a && b
        let result1: Bool? = aAndB || c
        #expect(result1 == nil)

        // true && (false || nil) = true && nil = nil
        let bOrC: Bool? = b || c
        let result2: Bool? = a && bOrC
        #expect(result2 == nil)

        // (true || nil) && false = true && false = false
        let aOrC: Bool? = a || c
        let result3: Bool? = aOrC && b
        #expect(result3 == .some(false))
    }
}
