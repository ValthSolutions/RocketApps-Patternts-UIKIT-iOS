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
    ],
    
    dependencies: [
        .package(url: "git@github.com:Paletech/iOS-layout.git", branch: "develop"),
        .package(url: "https://github.com/apphud/ApphudSDK", from: "3.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.55.0"),
    ],
    
    targets: [
        .target(
            name: "Styling",
            resources: [
                .process("Resources")
            ]),
        .target(
            name: "RocketComponents",
            dependencies: ["Styling",
                           "RocketNavigationComponents",
                           "RocketBasicComponents"]),
        .target(
            name: "RocketNavigationComponents",
            dependencies: ["Styling"]),
        .target(
            name: "RocketBasicComponents",
            dependencies: ["Styling",
                           .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                           .product(name: "ApphudSDK", package: "ApphudSDK"),
                           .product(name: "LayoutKit", package: "iOS-layout")
            ], resources: [
                .process("NavigationController/Resources")
            ]
        ),
    ]
)
