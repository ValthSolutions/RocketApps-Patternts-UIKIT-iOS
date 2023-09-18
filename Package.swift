// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RocketApps-Patternts-UIKIT-iOS",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RocketApps-Patternts-UIKIT-iOS",
            targets: ["RocketApps-Patternts-UIKIT-iOS"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RocketApps-Patternts-UIKIT-iOS"),
        .testTarget(
            name: "RocketApps-Patternts-UIKIT-iOSTests",
            dependencies: ["RocketApps-Patternts-UIKIT-iOS"]),
    ]
)
