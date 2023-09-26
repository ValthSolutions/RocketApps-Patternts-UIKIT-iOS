// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RocketSolutions",
    products: [
        .library(
            name: "RocketSolutions",
            targets: ["RocketSolutions"]),
    ],
    dependencies: [
        .package(path: "../RocketApps")
    ],
    targets: [
        .target(
            name: "RocketSolutions",
            dependencies: ["RocketComponents"])
    ]
)
