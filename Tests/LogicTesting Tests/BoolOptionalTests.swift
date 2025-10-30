//
//  File.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 19/07/2024.
//

import Foundation
import LogicTesting
import Testing

@Test("Bool?")
func iuygsdjf() {
    #expect(Bool?.allCases.count == 3)
}

@Test("[(Bool?)]")
func asdmasf() {
    #expect([(Bool?)].allCases.count == Bool?.allCases.count)
}

@Test("[(Bool?, Bool?)]?")
func asdhalk() {
    #expect([(Bool?, Bool?)].allCases.count == (3 ^^ 2))
}

@Test("[(Bool?, Bool?, Bool?)]")
func nsdhas() {
    #expect([(Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 3))
}

@Test("[(Bool?, Bool?, Bool?, Bool?)]")
func asdfga() {
    #expect([(Bool?, Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 4))
}
@Test("[(Bool?, Bool?, Bool?, Bool?, Bool?)]")
func sadaf() {
    #expect([(Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 5))
}
@Test("[(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)]")
func asdfasdf() {
    #expect([(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 6))
}
@Test("[(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)]")
func asdghgrfg() {
    #expect([(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 7))
}
@Test("[(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)]")
func sdfgsdfg() {
    #expect([(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 8))
}
@Test("[(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)]")
func ewsdfsf() {
    #expect([(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 9))
}
@Test("[(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)]")
func sdfsdf() {
    #expect([(Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?, Bool?)].allCases.count == (3 ^^ 10))
}
