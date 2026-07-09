// Tests for the collapse guards and explicit collapse accessors.
//
// The guarded operators are deliberately exercised here (this file compiles
// with DeprecatedDeclaration warnings by design): the assertions pin the
// shadow overloads to standard-library semantics, so adopting the module can
// never change runtime behavior. If a refactor genericizes the guards, the
// shadows stop being selected and these tests stop emitting the deprecation
// warnings — the semantics assertions still pass, so warning presence should
// additionally be checked when touching this target (see the load-bearing
// comment in the source file).

import Testing

@testable import Logic_Ternary_Primitives

@Suite
struct OptionalBoolStrictTests {
    static let values: [Bool?] = [true, false, nil]

    @Test(arguments: values, [true, false])
    func `equals Matches Standard Library Semantics`(_ lhs: Bool?, _ rhs: Bool) {
        // Standard-library value computed via the unguarded optional form.
        let expected = lhs == Optional(rhs)
        #expect((lhs == rhs) == expected)
    }

    @Test(arguments: values, [true, false])
    func `not Equals Matches Standard Library Semantics`(_ lhs: Bool?, _ rhs: Bool) {
        let expected = lhs != Optional(rhs)
        #expect((lhs != rhs) == expected)
    }

    @Test(arguments: values, [true, false])
    func `coalesce Matches Standard Library Semantics`(_ lhs: Bool?, _ rhs: Bool) {
        let expected: Bool = if case .some(let value) = lhs { value } else { rhs }
        #expect((lhs ?? rhs) == expected)
    }

    @Test
    func `explicit Collapse Accessors`() {
        #expect((true as Bool?).isTrue)
        #expect(!(false as Bool?).isTrue)
        #expect(!(nil as Bool?).isTrue)

        #expect(!(true as Bool?).isFalse)
        #expect((false as Bool?).isFalse)
        #expect(!(nil as Bool?).isFalse)

        #expect(!(true as Bool?).isUnknown)
        #expect(!(false as Bool?).isUnknown)
        #expect((nil as Bool?).isUnknown)
    }
}
