// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Games",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Games",
            targets: ["Games"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.4")),
        .package(url: "https://github.com/Centauryal/Core-Codebase.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "../Common")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Games",
            dependencies: [
                .product(name: "Core", package: "Core-Codebase"),
                "Alamofire",
                "Common"
            ]),
        .testTarget(
            name: "GamesTests",
            dependencies: ["Games"]),
    ]
)
