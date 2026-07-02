// MARK: - Collapse Guards

// These overloads intentionally shadow the standard-library spellings that
// silently collapse Kleene unknown (`nil`) into a definite verdict. Importing
// this module opts a file into Strong Kleene semantics for `Bool?`, and under
// those semantics a literal comparison is almost always a bug — so the guards
// live here, in the ternary module itself, rather than in an opt-in sibling.
//
// They are CONCRETE on `(Bool?, Bool)` / `(Bool, Bool?)` on purpose: a generic
// overload constrained to `Logic.Ternary.Protocol` loses overload resolution
// to the standard library's generic `== (T?, T?)` and never fires (verified
// empirically, 2026-07-02). An `@available(*, unavailable)` marking also does
// not work: the type checker excludes unavailable candidates whenever a viable
// standard-library overload exists. Deprecated + concrete is the only shape
// that both wins resolution and diagnoses. Do not genericize; do not switch
// to `unavailable`.
//
// Runtime semantics are identical to the standard-library forms, so these
// guards are behavior-neutral: existing code gains diagnostics, not different
// values. This module's own truth tables use the explicit accessors below.
//
// Body spellings route through the standard library's OPTIONAL-OPTIONAL
// operators (`.some(…)` on the definite side) so no body can re-select a
// guard: `lhs ?? rhs()` written naively selects THIS module's `??` (infinite
// recursion), and a bare `value != rhs` re-selects the concrete `!=` — both
// verified failure modes. Keep the `.some(…)` forms.

/// Compares a ternary value against a definite Boolean, collapsing `unknown`.
///
/// In Strong Kleene semantics `nil` means "not yet assessed". This comparison maps it to `false`, turning an epistemic gap into a definite verdict — which is almost never intended in ternary-logic code.
@available(*, deprecated, message: "collapses Kleene unknown to a definite verdict — compose with Bool?.all/any, &&, ||, ! instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown")
public func == (lhs: Bool?, rhs: Bool) -> Bool {
    lhs == .some(rhs)
}

/// Compares a definite Boolean against a ternary value, collapsing `unknown`.
///
/// The reversed spelling of the same collapse: `true == verdict` maps an unassessed verdict to `false`.
@available(*, deprecated, message: "collapses Kleene unknown to a definite verdict — compose with Bool?.all/any, &&, ||, ! instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown")
public func == (lhs: Bool, rhs: Bool?) -> Bool {
    .some(lhs) == rhs
}

/// Compares a ternary value against a definite Boolean, collapsing `unknown`.
///
/// In Strong Kleene semantics `nil` means "not yet assessed". This comparison maps it to `true`, affirming a verdict from an epistemic gap — the most dangerous collapse direction for exception ("tenzij") clauses.
@available(*, deprecated, message: "collapses Kleene unknown — negate with ! (Kleene) instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown")
public func != (lhs: Bool?, rhs: Bool) -> Bool {
    lhs != .some(rhs)
}

/// Compares a definite Boolean against a ternary value, collapsing `unknown`.
///
/// The reversed spelling of the same collapse: `true != verdict` maps an unassessed verdict to `true`.
@available(*, deprecated, message: "collapses Kleene unknown — negate with ! (Kleene) instead; if the collapse is intended, spell it explicitly with .isTrue / .isFalse / .isUnknown")
public func != (lhs: Bool, rhs: Bool?) -> Bool {
    .some(lhs) != rhs
}

/// Compares two definite Booleans.
///
/// Companion to the directional `!=` guards above: the standard library provides `!=` only generically over `Equatable`, so without this concrete overload a plain `Bool != Bool` expression would be ambiguous between the two one-promotion guard candidates. Exact match wins here; no collapse is involved, hence no deprecation.
@inlinable
public func != (lhs: Bool, rhs: Bool) -> Bool {
    !(lhs == rhs)
}

/// Coalesces a ternary value into a definite Boolean, collapsing `unknown`.
///
/// In Strong Kleene semantics `nil` means "not yet assessed". Nil-coalescing silently converts that epistemic gap into the fallback verdict.
@available(*, deprecated, message: "collapses Kleene unknown — a nil-coalesced verdict silently converts 'not assessed' into a definite value; compose with Kleene operators or spell the collapse explicitly with .isTrue / .isFalse / .isUnknown")
public func ?? (lhs: Bool?, rhs: @autoclosure () -> Bool) -> Bool {
    switch lhs {
    case .some(let value): value
    case nil: rhs()
    }
}

// MARK: - Explicit Collapse Accessors

extension Optional where Wrapped == Bool {
    /// Whether the proposition is definitively established.
    ///
    /// The sanctioned, greppable spelling for an intentional collapse: `true` only for `.some(true)`; both `false` and `unknown` yield `false`.
    @inlinable
    public var isTrue: Bool { self == .some(true) }

    /// Whether the proposition is definitively refuted.
    ///
    /// The sanctioned, greppable spelling for an intentional collapse: `true` only for `.some(false)`; both `true` and `unknown` yield `false`.
    @inlinable
    public var isFalse: Bool { self == .some(false) }

    /// Whether the proposition has not been assessed.
    @inlinable
    public var isUnknown: Bool { self == nil }
}
