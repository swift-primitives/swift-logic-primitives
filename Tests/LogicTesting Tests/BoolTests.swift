//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 21/07/2024.
//

import Foundation
import LogicTesting
import Testing

@Test("Bool")
func booliuygsdjf() {
    #expect(Bool.allCases.count == 2)
}

@Test("[(Bool)]")
func boolasdmasf() {
    #expect([(Bool)].allCases.count == Bool.allCases.count)
}

@Test("[(Bool, Bool)]?")
func boolasdhalk() {
    #expect([(Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 2))
}

@Test("[(Bool, Bool, Bool)]")
func boolnsdhas() {
    #expect([(Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 3))
}

@Test("[(Bool, Bool, Bool, Bool)]")
func boolasdfga() {
    #expect([(Bool, Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 4))
}
@Test("[(Bool, Bool, Bool, Bool, Bool)]")
func boolsadaf() {
    #expect([(Bool, Bool, Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 5))
}
@Test("[(Bool, Bool, Bool, Bool, Bool, Bool)]")
func boolasdfasdf() {
    #expect([(Bool, Bool, Bool, Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 6))
}
@Test("[(Bool, Bool, Bool, Bool, Bool, Bool, Bool)]")
func boolasdghgrfg() {
    #expect([(Bool, Bool, Bool, Bool, Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 7))
}
@Test("[(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)]")
func boolsdfgsdfg() {
    #expect([(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 8))
}
@Test("[(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)]")
func boolewsdfsf() {
    #expect([(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 9))
}
@Test("[(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)]")
func boolsdfsdf() {
    #expect([(Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)].allCases.count == (Bool.allCases.count ^^ 10))
}
