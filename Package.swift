// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "shared-modules",
    platforms: [
      .iOS(.v16),
      .macOS(.v13)
    ],
    products: [
        .library(
            name: "DTOs",
            targets: ["DTOs"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [
            ],
            path: "IOS/DTOs",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "Tests",
            dependencies: [
                .target(name: "DTOs"),
            ],
            path: "IOS/Tests",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .swiftLanguageMode(.v6)
            ]
        ),
    ]
)
