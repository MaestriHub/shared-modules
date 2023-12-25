// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedModules",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "DTOs",
            targets: [ "DTOs" ]
        ),
        .library(
            name: "MaestriSDK",
            targets: ["MaestriSDK"]
        ),
		.library(
            name: "Karte",
            targets: [ "Karte" ]
        ),
        .library(
            name: "SwifCron", 
            targets: [ "SwifCron" ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: "5.8.0")),
        .package(url: "https://github.com/WeTransfer/Mocker", .upToNextMajor(from: "3.0.1")),
        .package(url: "https://github.com/kean/Pulse", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", .upToNextMajor(from: "4.2.2")),
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [],
            path: "DTOs"
        ),
        .target(
            name: "MaestriSDK",
            dependencies: [
                "DTOs",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Mocker", package: "Mocker"),
                .product(name: "Pulse", package: "Pulse"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ],
            path: "MaestriSDK/Sources"
        ),
        .target(
            name: "SwifCron",
            dependencies: [],
            path: "SwifCron/Sources"
        ),
		.target(
            name: "Karte",
            dependencies: [],
            path: "Karte"
        ),
        .testTarget(
            name: "SwifCronTests",
            dependencies: ["SwifCron"],
            path: "SwifCron/Tests"
        ),
    ]
)
