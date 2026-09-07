// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-rounding",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [
        .library(name: "Rounding", targets: ["Rounding"]),
        .library(name: "Rounding Foundation Integration", targets: ["Rounding Foundation Integration"]),
        .library(name: "Rounding Test Support", targets: ["Rounding Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-comparison.git", branch: "main"),
    ],
    targets: [
        .target(name: "Rounding", dependencies: [.product(name: "Comparison", package: "swift-comparison")], path: "Sources/Rounding"),
        .target(name: "Rounding Foundation Integration", dependencies: ["Rounding"], path: "Sources/Rounding Foundation Integration"),
        .target(name: "Rounding Test Support", dependencies: ["Rounding"], path: "Tests/Support"),
        .testTarget(name: "Rounding Tests", dependencies: ["Rounding", "Rounding Foundation Integration", "Rounding Test Support"], path: "Tests/Rounding Tests"),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
