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
        .library(
            name: "Aborts",
            targets: [ "Aborts" ]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [],
            path: "DTOs"
        ),
        .target(
            name: "SwifCron",
            dependencies: [],
            path: "SwifCron/Sources"
        ),
        .target(
            name: "Aborts",
            dependencies: [],
            path: "Aborts"
        ),
        .testTarget(
            name: "SwifCronTests",
            dependencies: ["SwifCron"],
            path: "SwifCron/Tests"
        ),
    ]
)
