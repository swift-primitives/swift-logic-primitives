// swift-tools-version:5.10.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    static let logicOperators: Self = "LogicOperators"
    static let logicTesting: Self = "LogicTesting"
    static let closure: Self = "PredicateLogic"
    static let optional: Self = "OptionalLogic"
    static let optionalViews: Self = "OptionalViews"
}

extension Target.Dependency {
    static var logicOperators: Self { .target(name: .logicOperators) }
    static var logicTesting: Self { .target(name: .logicTesting) }
    static var closure: Self { .target(name: .closure) }
    static var optional: Self { .target(name: .optional) }
}

extension Package {
    static func logicOperators(
        targets: [(name: String, dependencies: [Target.Dependency])]
    ) -> Package {

        let names = targets.map(\.name)

        return Package(
            name: "swift-logic-operators",
            platforms: [ .macOS(.v10_15), .iOS(.v13) ],
//            platforms: [ .macOS(.v14), .iOS(.v13) ],
            products: [
                names.map { name in
                        .library(
                            name: name,
                            targets: [.init(stringLiteral: name)]
                        )
                }
            ].flatMap { $0 },
            targets: [
                targets.map { document in
                    Target.target(
                        name: "\(document.name)",
                        dependencies: document.dependencies
                    )
                },
                targets.map { document in
                    Target.testTarget(
                        name: "\(document.name) Tests",
                        dependencies: [
                            Target.Dependency(stringLiteral: document.name),
                            document.name != .logicTesting ? .logicTesting : nil
                        ].compactMap { $0 }
                    )
                }
            ].flatMap { $0 },
            swiftLanguageVersions: [.v5]
        )
    }
}

let package = Package.logicOperators(
    targets: [
        (
            name: .logicOperators,
            dependencies: [
                .closure,
                .optional
            ]
        ),
        (
            name: .logicTesting,
            dependencies: []
        ),
        (
            name: .closure,
            dependencies: []
        ),
        (
            name: .optional,
            dependencies: []
        ),
        (
            name: .optionalViews,
            dependencies: [
                .optional
            ]
        )
    ]
)
