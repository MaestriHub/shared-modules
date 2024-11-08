// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "shared-modules",
    products: [
        .library(
            name: "DTOs",
            targets: [ "DTOs" ]
        ),
        .library(
            name: "SwifCron", 
            targets: [ "SwifCron" ]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [],
            path: "IOS/DTOs"
        ),
        .target(
            name: "SwifCron",
            dependencies: [],
            path: "IOS/SwifCron/Sources"
        ),
        .testTarget(
            name: "SwifCronTests",
            dependencies: ["SwifCron"],
            path: "IOS/SwifCron/Tests"
        ),
    ]
)
