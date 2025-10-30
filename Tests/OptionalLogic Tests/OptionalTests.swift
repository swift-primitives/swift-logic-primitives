//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 21/07/2024.
//

import Foundation
import LogicTesting
import OptionalLogic
import Testing

@Test("!", arguments: Bool?.allCases)
func notTest(optional: Bool?) {
    switch optional {
    case .some(true):
        #expect(!optional == false)
    case .some(false):
        #expect(!optional == true)
    case .none:
        #expect(!optional == nil)
    }
}

@Test("!=", arguments: Bool?.allCases, Bool?.allCases)
func notEqualsTest(left: Bool?, right: Bool?) {
    switch (left, right) {
    case (.none, .none):
        #expect((left != right) == false) // Two nil values are considered equal, so `!=` should return false.
    case (.none, _):
        #expect((left != right) == true) // nil != anything is true, since nil is considered different from any value.
    case (_, .none):
        #expect((left != right) == true) // anything != nil is true, similar reasoning as above.
    case let (.some(l), .some(r)):
        #expect((left != right) == !(l == r)) // Compare the values directly if both are non-nil.
    }
}

@Test("!", arguments: Bool?.allCases)
func nandTest(bool: Bool?) {
    switch bool {
    case .some(true):
        #expect(!bool == false)
    case .some(false):
        #expect(!bool == true)
    case .none:
        #expect(!bool == nil)
    }
}

@Test("!&&", arguments: Bool?.allCases, Bool?.allCases)
func nandTest2(left: Bool?, right: Bool?) {
    switch (left, right) {
    case (.none, _):
        #expect((left !&& right) == .none)
    case (_, .none):
        #expect((left !&& right) == .none)
    case (.some(let l), .some(let r)):
        #expect((left !&& right) == !(l && r))
    }
}

@Test("&&", arguments: Bool?.allCases, Bool?.allCases)
func andTest(left: Bool?, right: Bool?) {
    switch (left, right) {
    case (.none, _):
        #expect((left && right) == .none)
    case (_, .none):
        #expect((left && right) == .none)
    case let (.some(l), .some(r)):
        #expect((left && right) == (l && r))
    }
}

@Test("&&")
func andTest2() {

    #expect((Bool?.none && Bool?.none) == nil)
}

@Test("!^", arguments: Bool?.allCases, Bool?.allCases)
func xnorTest(left: Bool?, right: Bool?) {
    switch (left, right) {
    case (.none, _):
        #expect((left !^ right) == .none)
    case (_, .none):
        #expect((left !^ right) == .none)
    case (.some(let l), .some(let r)):
        #expect((left !^ right) == (l == r))
    }
}

@Test("==", arguments: Bool?.allCases, Bool?.allCases)
func equalsTest(left: Bool?, right: Bool?) {
    switch (left, right) {
    case (_, .none):
        #expect((left == right) == .none)
    case (.none, _):
        #expect((left == right) == .none)
    case let (.some(l), .some(r)):
        #expect((left == right) == (l == r))
    }
}

@Test("!||", arguments: Bool?.allCases, Bool?.allCases)
func norTest(left: Bool?, right: Bool?) {
    switch (left, right) {
    case let (.some(l), .some(r)):
        #expect((left !|| right) == !(l || r))
    case let (.none, .some(r)):
        #expect((left !|| right) == (r == true ? false : nil))
    case let (.some(l), .none):
        #expect((left !|| right) == (l == true ? false : nil))
    case (.none, .none):
        #expect((left !|| right) == nil)
    }
}

@Test("||", arguments: Bool?.allCases, Bool?.allCases)
func orTest(left: Bool?, right: Bool?) {
    switch (left, right) {
    case let (.some(l), .some(r)):
        #expect((left || right) == (l || r))
    case let (.none, .some(r)):
        #expect((left || right) == (r == true ? true : nil))
    case let (.some(l), .none):
        #expect((left || right) == (l == true ? true : nil))
    case (.none, .none):
        #expect((left || right) == .none)
    }
}

@Test("||")
func orTest2() {
    #expect((Bool?.none || Bool?.none || Bool?.none || Bool?.none || Bool?.none) == Bool?.none)
}
