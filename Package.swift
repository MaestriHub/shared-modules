// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedModules",
    products: [
        .library(
            name: "SharedModules",
            targets: [
                "DTOs"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/MihaelIsaev/SwifCron.git", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [
                .product(name: "SwifCron", package: "SwifCron"),
            ],
            path: "Sources/DTOs"
        ),
    ]
)
