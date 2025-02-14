// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "shared-modules",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "DTOs",
            targets: ["DTOs"]
        )
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [],
            path: "IOS/DTOs"
        )
    ]
)
