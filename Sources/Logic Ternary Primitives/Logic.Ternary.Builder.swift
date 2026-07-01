// MARK: - Logic.Ternary Builders

extension Logic.Ternary {
    /// Namespace for ternary logic result builders.
    ///
    /// Provides result builders (`All`, `Any`, `None`) that implement Strong Kleene three-valued logic with Swift's result builder syntax. Use these to combine multiple ternary conditions declaratively.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.all {
    ///     true
    ///     nil  // unknown
    ///     true
    /// }
    /// // result = nil (unknown propagates)
    /// ```
    public enum Builder<T: Logic.Ternary.`Protocol`> {
        /// A result builder that combines ternary conditions with AND semantics.
        ///
        /// Returns `false` if any condition is `false` (short-circuits), `unknown` if any condition is `unknown` and none are `false`, or `true` only if all conditions are `true`.
        ///
        /// ## Example
        ///
        /// ```swift
        /// let result = Logic.Ternary.all {
        ///     true
        ///     nil    // unknown
        ///     true
        /// }
        /// // result = nil (unknown)
        /// ```
        @resultBuilder
        public enum All {
            /// Lifts a ternary value into the builder.
            @inlinable
            public static func buildExpression(_ expression: T) -> T {
                expression
            }

            /// Lifts a Boolean value into the builder as its ternary equivalent.
            @inlinable
            public static func buildExpression(_ expression: Bool) -> T {
                T(expression)
            }

            /// Starts a block with its first ternary component.
            @inlinable
            public static func buildPartialBlock(first: T) -> T {
                first
            }

            /// Starts an empty block at the conjunction identity, `true`.
            @inlinable
            public static func buildPartialBlock(first: Void) -> T {
                .true
            }

            /// Starts a block whose first component is unreachable.
            @inlinable
            public static func buildPartialBlock(first: Never) -> T {}

            /// Combines the running result with the next component under Strong Kleene AND.
            @inlinable
            public static func buildPartialBlock(accumulated: T, next: T) -> T {
                // Strong Kleene AND: false dominates, then unknown, then true
                if T.from(accumulated) == false || T.from(next) == false {
                    return .false
                }
                if T.from(accumulated) == nil || T.from(next) == nil {
                    return .unknown
                }
                return .true
            }

            /// Builds an empty block as the conjunction identity, `true`.
            @inlinable
            public static func buildBlock() -> T {
                .true
            }

            /// Treats an omitted optional component as `unknown`.
            @inlinable
            public static func buildOptional(_ component: T?) -> T {
                // Missing value means unknown in ternary logic
                component ?? .unknown
            }

            /// Selects the first branch of a conditional component.
            @inlinable
            public static func buildEither(first: T) -> T {
                first
            }

            /// Selects the second branch of a conditional component.
            @inlinable
            public static func buildEither(second: T) -> T {
                second
            }

            /// Combines a loop's components under Strong Kleene AND.
            @inlinable
            public static func buildArray(_ components: [T]) -> T {
                var hasUnknown = false
                for component in components {
                    if T.from(component) == false {
                        return .false
                    }
                    if T.from(component) == nil {
                        hasUnknown = true
                    }
                }
                return hasUnknown ? .unknown : .true
            }

            /// Propagates a component produced inside a limited-availability block.
            @inlinable
            public static func buildLimitedAvailability(_ component: T) -> T {
                component
            }
        }

        /// A result builder that combines ternary conditions with OR semantics.
        ///
        /// Returns `true` if any condition is `true` (short-circuits), `unknown` if any condition is `unknown` and none are `true`, or `false` only if all conditions are `false`.
        ///
        /// ## Example
        ///
        /// ```swift
        /// let result = Logic.Ternary.any {
        ///     false
        ///     nil    // unknown
        ///     false
        /// }
        /// // result = nil (unknown)
        /// ```
        @resultBuilder
        public enum `Any` {
            /// Lifts a ternary value into the builder.
            @inlinable
            public static func buildExpression(_ expression: T) -> T {
                expression
            }

            /// Lifts a Boolean value into the builder as its ternary equivalent.
            @inlinable
            public static func buildExpression(_ expression: Bool) -> T {
                T(expression)
            }

            /// Starts a block with its first ternary component.
            @inlinable
            public static func buildPartialBlock(first: T) -> T {
                first
            }

            /// Starts an empty block at the disjunction identity, `false`.
            @inlinable
            public static func buildPartialBlock(first: Void) -> T {
                .false
            }

            /// Starts a block whose first component is unreachable.
            @inlinable
            public static func buildPartialBlock(first: Never) -> T {}

            /// Combines the running result with the next component under Strong Kleene OR.
            @inlinable
            public static func buildPartialBlock(accumulated: T, next: T) -> T {
                // Strong Kleene OR: true dominates, then unknown, then false
                if T.from(accumulated) == true || T.from(next) == true {
                    return .true
                }
                if T.from(accumulated) == nil || T.from(next) == nil {
                    return .unknown
                }
                return .false
            }

            /// Builds an empty block as the disjunction identity, `false`.
            @inlinable
            public static func buildBlock() -> T {
                .false
            }

            /// Treats an omitted optional component as `unknown`.
            @inlinable
            public static func buildOptional(_ component: T?) -> T {
                component ?? .unknown
            }

            /// Selects the first branch of a conditional component.
            @inlinable
            public static func buildEither(first: T) -> T {
                first
            }

            /// Selects the second branch of a conditional component.
            @inlinable
            public static func buildEither(second: T) -> T {
                second
            }

            /// Combines a loop's components under Strong Kleene OR.
            @inlinable
            public static func buildArray(_ components: [T]) -> T {
                var hasUnknown = false
                for component in components {
                    if T.from(component) == true {
                        return .true
                    }
                    if T.from(component) == nil {
                        hasUnknown = true
                    }
                }
                return hasUnknown ? .unknown : .false
            }

            /// Propagates a component produced inside a limited-availability block.
            @inlinable
            public static func buildLimitedAvailability(_ component: T) -> T {
                component
            }
        }

        /// A result builder that requires no conditions to be true (NOR semantics).
        ///
        /// Returns `true` if all conditions are `false`, `unknown` if any condition is `unknown` and none are `true`, or `false` if any condition is `true`.
        ///
        /// ## Example
        ///
        /// ```swift
        /// let result = Logic.Ternary.none {
        ///     false
        ///     false
        /// }
        /// // result = true (none are true)
        /// ```
        @resultBuilder
        public enum None {
            /// Lifts a ternary value into the builder.
            @inlinable
            public static func buildExpression(_ expression: T) -> T {
                expression
            }

            /// Lifts a Boolean value into the builder as its ternary equivalent.
            @inlinable
            public static func buildExpression(_ expression: Bool) -> T {
                T(expression)
            }

            /// Starts a block with its first ternary component.
            @inlinable
            public static func buildPartialBlock(first: T) -> T {
                first
            }

            /// Starts an empty block at the disjunction identity, `false`, before negation.
            @inlinable
            public static func buildPartialBlock(first: Void) -> T {
                .false
            }

            /// Starts a block whose first component is unreachable.
            @inlinable
            public static func buildPartialBlock(first: Never) -> T {}

            /// Accumulates components under Strong Kleene OR for later negation.
            @inlinable
            public static func buildPartialBlock(accumulated: T, next: T) -> T {
                // Collect for OR (will be negated in buildFinalResult)
                if T.from(accumulated) == true || T.from(next) == true {
                    return .true
                }
                if T.from(accumulated) == nil || T.from(next) == nil {
                    return .unknown
                }
                return .false
            }

            /// Builds an empty block as the disjunction identity, `false`, before negation.
            @inlinable
            public static func buildBlock() -> T {
                .false
            }

            /// Treats an omitted optional component as `unknown`.
            @inlinable
            public static func buildOptional(_ component: T?) -> T {
                component ?? .unknown
            }

            /// Selects the first branch of a conditional component.
            @inlinable
            public static func buildEither(first: T) -> T {
                first
            }

            /// Selects the second branch of a conditional component.
            @inlinable
            public static func buildEither(second: T) -> T {
                second
            }

            /// Accumulates a loop's components under Strong Kleene OR for later negation.
            @inlinable
            public static func buildArray(_ components: [T]) -> T {
                var hasUnknown = false
                for component in components {
                    if T.from(component) == true {
                        return .true
                    }
                    if T.from(component) == nil {
                        hasUnknown = true
                    }
                }
                return hasUnknown ? .unknown : .false
            }

            /// Propagates a component produced inside a limited-availability block.
            @inlinable
            public static func buildLimitedAvailability(_ component: T) -> T {
                component
            }

            /// Negates the accumulated disjunction to yield the NOR result.
            @inlinable
            public static func buildFinalResult(_ component: T) -> T {
                // NOR: negate the OR result
                switch T.from(component) {
                case true: return .false
                case false: return .true
                case nil: return .unknown
                }
            }
        }
    }
}

// MARK: - Convenience Entry Points

extension Logic.Ternary {
    /// Combines ternary conditions with AND semantics using a result builder.
    ///
    /// Returns `false` if any is `false`, `unknown` if any is `unknown` and none are `false`, or `true` if all are `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.all {
    ///     true
    ///     nil
    /// }
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func all<T: `Protocol`>(@Builder<T>.All _ builder: () -> T) -> T {
        builder()
    }

    /// Combines ternary conditions with OR semantics using a result builder.
    ///
    /// Returns `true` if any is `true`, `unknown` if any is `unknown` and none are `true`, or `false` if all are `false`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.any {
    ///     false
    ///     nil
    /// }
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func any<T: `Protocol`>(@Builder<T>.`Any` _ builder: () -> T) -> T {
        builder()
    }

    /// Combines ternary conditions with NOR semantics using a result builder.
    ///
    /// Returns `true` if all are `false`, `unknown` if any is `unknown` and none are `true`, or `false` if any is `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Logic.Ternary.none {
    ///     false
    ///     false
    /// }
    /// // result = true (none are true)
    /// ```
    @inlinable
    public static func none<T: `Protocol`>(@Builder<T>.None _ builder: () -> T) -> T {
        builder()
    }
}

// MARK: - Bool? Convenience (Type-level Entry Points)

extension Optional where Wrapped == Bool {
    /// Combines `Bool?` conditions with AND semantics using a result builder.
    ///
    /// Returns `false` if any is `false`, `nil` (unknown) if any is `nil` and none are `false`, or `true` if all are `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Bool?.all {
    ///     true
    ///     nil
    /// }
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func all(@Logic.Ternary.Builder<Bool?>.All _ builder: () -> Bool?) -> Bool? {
        builder()
    }

    /// Combines `Bool?` conditions with OR semantics using a result builder.
    ///
    /// Returns `true` if any is `true`, `nil` (unknown) if any is `nil` and none are `true`, or `false` if all are `false`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Bool?.any {
    ///     false
    ///     nil
    /// }
    /// // result = nil (unknown)
    /// ```
    @inlinable
    public static func any(@Logic.Ternary.Builder<Bool?>.`Any` _ builder: () -> Bool?) -> Bool? {
        builder()
    }

    /// Combines `Bool?` conditions with NOR semantics using a result builder.
    ///
    /// Returns `true` if all are `false`, `nil` (unknown) if any is `nil` and none are `true`, or `false` if any is `true`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let result = Bool?.none {
    ///     false
    ///     false
    /// }
    /// // result = true (none are true)
    /// ```
    @inlinable
    public static func none(@Logic.Ternary.Builder<Bool?>.None _ builder: () -> Bool?) -> Bool? {
        builder()
    }
}
