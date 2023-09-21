// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RocketApps",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Styling",
            targets: ["Styling"]),
        .library(
            name: "RocketComponents",
            targets: ["RocketComponents"]),
        .library(
            name: "RocketNavigationComponents",
            targets: ["RocketNavigationComponents"]),
        .library(
            name: "RocketBasicComponents",
            targets: ["RocketBasicComponents"]),
        .library(
            name: "RocketSolutions",
            targets: ["RocketSolutions"])
    ],
    targets: [
        .target(
            name: "Styling"),
        .target(
            name: "RocketComponents",
            dependencies: ["Styling",
                           "RocketNavigationComponents",
                           "RocketBasicComponents",
                           "RocketSolutions"]),
        .target(
            name: "RocketNavigationComponents",
            dependencies: ["Styling"]),
        .target(
            name: "RocketBasicComponents",
            dependencies: ["Styling"]),
        .target(
            name: "RocketSolutions",
            dependencies: ["Styling"])
    ]
)
