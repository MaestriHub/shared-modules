// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedModules",
    products: [
        .library(
            name: "DTOs",
            targets: [ "DTOs" ]
        ),
        .library(
            name: "Karte",
            targets: [ "Karte" ]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [
            ],
            path: "DTOs"
        ),
        .target(
            name: "Karte",
            dependencies: [
            ],
            path: "Karte"
        ),
    ]
)
