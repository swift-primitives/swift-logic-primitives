// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-logic-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        // MARK: - Namespace (per [MOD-017])
        .library(
            name: "Logic Primitive",
            targets: ["Logic Primitive"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Logic Primitives",
            targets: ["Logic Primitives"]
        ),

        .library(
            name: "Logic Ternary Primitives",
            targets: ["Logic Ternary Primitives"]
        ),
        .library(
            name: "Logic Primitives Test Support",
            targets: ["Logic Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-standard-library-extensions.git", branch: "main")
    ],
    targets: [
        // MARK: - Namespace (per [MOD-017])
        // Zero external deps. Owns `public enum Logic` + all stdlib-only
        // foundational decls (the Logic namespace, Logic.Protocol, Bool
        // conformance, and the Logic.{and,or,not,xor,…} operator functions).
        .target(
            name: "Logic Primitive",
            dependencies: []
        ),

        // MARK: - Ternary
        .target(
            name: "Logic Ternary Primitives",
            dependencies: [
                "Logic Primitive"
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Logic Primitives",
            dependencies: [
                "Logic Primitive",
                "Logic Ternary Primitives",
            ]
        ),
        .testTarget(
            name: "Logic Primitives Tests",
            dependencies: [
                "Logic Primitives",
            ]
        ),
        .testTarget(
            name: "Logic Ternary Primitives Tests",
            dependencies: [
                "Logic Ternary Primitives",
                // The Builder tests use `Bool.all` from Standard Library Extensions.
                // Pre-migration this resolved transitively through the Core SLE funnel;
                // the funnel is redistributed per [MOD-038], so declare it directly.
                .product(name: "Standard Library Extensions", package: "swift-standard-library-extensions"),
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Logic Primitives Test Support",
            dependencies: [
                "Logic Primitives",
            ],
            path: "Tests/Support"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
