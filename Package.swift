// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "shared-modules",
    platforms: [
      .iOS(.v16),
      .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "DTOs",
            targets: ["DTOs"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro", from: "0.5.2")
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [
                .product(name: "MemberwiseInit", package: "swift-memberwise-init-macro"),
            ],
            path: "IOS/DTOs"
        )
    ]
)
