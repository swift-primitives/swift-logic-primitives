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
}

// =============================================================================
// MARK: - Tests blocked by swiftlang/swift#86596
// =============================================================================
// The following tests use operators with @autoclosure () throws(E) -> T which
// cannot infer E = Never for non-throwing expressions. These tests will be
// re-enabled once the Swift bug is fixed.
//
// See: https://github.com/swiftlang/swift/issues/86596

#if false  // Blocked by swiftlang/swift#86596

    // MARK: - AND Tests

    @Suite
    struct ThreeValuedLogicANDTests {
        static let andCases: [BinaryTestCase] = [
            // Known values
            .init(lhs: false, rhs: false, expected: false),
            .init(lhs: false, rhs: true, expected: false),
            .init(lhs: true, rhs: false, expected: false),
            .init(lhs: true, rhs: true, expected: true),
            // Short-circuit on false
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

        @Test
        func lazyEvaluation() {
            var evaluated = false
            // Should NOT evaluate rhs when lhs is false
            let _: Bool? = Logic.Ternary.and(
                false,
                {
                    evaluated = true
                    return true
                }()
            )
            #expect(evaluated == false)
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
            // Short-circuit on true
            .init(lhs: true, rhs: nil, expected: true),
            .init(lhs: nil, rhs: true, expected: true),
            // Nil propagation
            .init(lhs: false, rhs: nil, expected: nil),
            .init(lhs: nil, rhs: false, expected: nil),
            .init(lhs: nil, rhs: nil, expected: nil),
        ]

        @Test(arguments: orCases)
        func or(_ testCase: BinaryTestCase) {
            let result: Bool? = testCase.lhs || testCase.rhs
            #expect(result == testCase.expected)
        }

        @Test
        func lazyEvaluation() {
            var evaluated = false
            let lazyValue: () -> Bool? = {
                evaluated = true
                return false
            }
            // Should NOT evaluate rhs when lhs is true
            _ = true || lazyValue()
            #expect(evaluated == false)
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
        ]

        @Test(arguments: norCases)
        func nor(_ testCase: BinaryTestCase) {
            let result: Bool? = testCase.lhs !|| testCase.rhs
            #expect(result == testCase.expected)
        }
    }

    // MARK: - De Morgan Tests

    @Suite
    struct ThreeValuedLogicDeMorganTests {
        static let knownPairs: [(Bool, Bool)] = [
            (false, false),
            (false, true),
            (true, false),
            (true, true),
        ]

        @Test(arguments: knownPairs)
        func deMorganAnd(_ pair: (Bool, Bool)) {
            let (a, b) = pair
            // !(a && b) == !a || !b
            let lhs: Bool? = !(a && b)
            let rhs: Bool? = !a || !b
            #expect(lhs == rhs)
        }

        @Test(arguments: knownPairs)
        func deMorganOr(_ pair: (Bool, Bool)) {
            let (a, b) = pair
            // !(a || b) == !a && !b
            let lhs: Bool? = !(a || b)
            let rhs: Bool? = !a && !b
            #expect(lhs == rhs)
        }

        @Test
        func deMorganWithNil() {
            let nilValue: Bool? = nil
            // !(false && nil) = !false = true
            // !false || !nil = true || nil = true ✓
            let lhs1: Bool? = !(false && nilValue)
            let rhs1: Bool? = !false || !nilValue
            #expect(lhs1 == rhs1)
            // !(true || nil) = !true = false
            // !true && !nil = false && nil = false ✓
            let lhs2: Bool? = !(true || nilValue)
            let rhs2: Bool? = !true && !nilValue
            #expect(lhs2 == rhs2)
        }
    }

    // MARK: - Implication Tests

    @Suite
    struct ThreeValuedLogicImplicationTests {
        struct ImplicationCase: CustomTestStringConvertible, Sendable {
            let a: Bool?
            let b: Bool?
            let expected: Bool?

            var testDescription: String {
                "\(a.map(String.init(describing:)) ?? "nil") → \(b.map(String.init(describing:)) ?? "nil") = \(expected.map(String.init(describing:)) ?? "nil")"
            }
        }

        static let implicationCases: [ImplicationCase] = [
            .init(a: true, b: true, expected: true),
            .init(a: true, b: false, expected: false),
            // false → anything = true (vacuous truth)
            .init(a: false, b: true, expected: true),
            .init(a: false, b: false, expected: true),
            .init(a: false, b: nil, expected: true),
            // nil → true = nil || true = true
            .init(a: nil, b: true, expected: true),
            // nil → false = nil || false = nil
            .init(a: nil, b: false, expected: nil),
        ]

        /// Verifies that implication a → b matches (not a) or b.
        @Test(arguments: implicationCases)
        func implication(_ testCase: ImplicationCase) {
            let result: Bool? = !testCase.a || testCase.b
            #expect(result == testCase.expected)
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
            #expect(result3 == false)
        }
    }

#endif  // Blocked by swiftlang/swift#86596
