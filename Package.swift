// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BaseFoundationiOS",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16), .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BaseFoundationiOS",
            targets: ["BaseFoundationiOS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.7.1")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2"),
    ],
    targets: [
        .target(
            name: "BaseFoundationiOS",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ],
            resources: [
                .process("SupportingFiles")
            ]),
        .testTarget(
            name: "BaseFoundationiOSTests",
            dependencies: ["BaseFoundationiOS"]),
    ],
    swiftLanguageVersions: [.v5]
)
