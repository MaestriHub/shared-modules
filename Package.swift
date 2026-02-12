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
            path: "iOS-legacy/DTOs",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
    ]
)
