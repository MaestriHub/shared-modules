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
            name: "MaestriSDK",
            targets: [ "MaestriSDK" ]
        ),
    ],
    dependencies: [
        .package(path: "../DTOs"),
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: "5.8.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", .upToNextMajor(from: "4.2.2")),
    ],
    targets: [
        .target(
            name: "DTOs",
            dependencies: [],
            path: "IOS/DTOs"
        ),
        .target(
            name: "MaestriSDK",
            dependencies: [
                .product(name: "DTOs", package: "DTOs"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ],
            path: "IOS/SDK"
        ),
    ]
)
