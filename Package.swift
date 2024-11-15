// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "shared-modules",
    platforms: [
      .iOS(.v13),
      .macOS(.v10_15),
      .tvOS(.v13),
      .watchOS(.v6),
    ],
    products: [
        .library(
            name: "DTOs",
            targets: ["DTOs"]
        ),
        .library(
            name: "MaestriSDK",
            targets: ["MaestriSDK"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: "5.10.1")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.5.2")),
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
                "DTOs",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ],
            path: "IOS/SDK"
        ),
    ]
)
