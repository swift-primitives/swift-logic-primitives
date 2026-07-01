// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Testing

@testable import Logic_Primitives

@Suite
struct LogicOperatorTests {

    // MARK: - AND

    @Test
    func and() {
        #expect(Logic.and(true, true) == true)
        #expect(Logic.and(true, false) == false)
        #expect(Logic.and(false, true) == false)
        #expect(Logic.and(false, false) == false)
    }

    // MARK: - OR

    @Test
    func or() {
        #expect(Logic.or(true, true) == true)
        #expect(Logic.or(true, false) == true)
        #expect(Logic.or(false, true) == true)
        #expect(Logic.or(false, false) == false)
    }

    // MARK: - NOT

    @Test
    func not() {
        #expect(Logic.not(true) == false)
        #expect(Logic.not(false) == true)
    }

    // MARK: - XOR

    @Test
    func xor() {
        #expect(Logic.xor(true, true) == false)
        #expect(Logic.xor(true, false) == true)
        #expect(Logic.xor(false, true) == true)
        #expect(Logic.xor(false, false) == false)
    }

    // MARK: - NAND

    @Test
    func nand() {
        #expect(Logic.nand(true, true) == false)
        #expect(Logic.nand(true, false) == true)
        #expect(Logic.nand(false, true) == true)
        #expect(Logic.nand(false, false) == true)
    }

    // MARK: - NOR

    @Test
    func nor() {
        #expect(Logic.nor(true, true) == false)
        #expect(Logic.nor(true, false) == false)
        #expect(Logic.nor(false, true) == false)
        #expect(Logic.nor(false, false) == true)
    }

    // MARK: - XNOR

    @Test
    func xnor() {
        #expect(Logic.xnor(true, true) == true)
        #expect(Logic.xnor(true, false) == false)
        #expect(Logic.xnor(false, true) == false)
        #expect(Logic.xnor(false, false) == true)
    }

    // MARK: - Implication

    @Test
    func implies() {
        #expect(Logic.implies(true, true) == true)
        #expect(Logic.implies(true, false) == false)
        #expect(Logic.implies(false, true) == true)
        #expect(Logic.implies(false, false) == true)
    }

    // MARK: - Biconditional

    @Test
    func iff() {
        #expect(Logic.iff(true, true) == true)
        #expect(Logic.iff(true, false) == false)
        #expect(Logic.iff(false, true) == false)
        #expect(Logic.iff(false, false) == true)
    }
}

@Suite
struct BoolLogicProtocolTests {

    @Test
    func boolConformance() {
        // Bool conforms to Logic.Protocol
        let t: Bool = .true
        let f: Bool = .false

        #expect(t == true)
        #expect(f == false)
        #expect(Bool.from(true) == true)
        #expect(Bool.from(false) == false)
        #expect(Bool(true) == true)
        #expect(Bool(false) == false)
    }
}
