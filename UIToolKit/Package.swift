// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let package = Package(
    name: "UIToolKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "UIToolKit",
            targets: ["UIToolKit"]
        )
    ],
    dependencies: [
        .package(
            name: "Theme",
            path: "../../Theme"
        ),
        .package(
            name: "Extensions",
            path: "../../Extensions"
        ),
        .package(url: "https://github.com/airbnb/lottie-spm", from: "4.5.0")
    ],
    targets: [
        .target(
            name: "UIToolKit",
            dependencies: [
                "Theme", "Extensions",
                .product(name: "Lottie", package: "lottie-spm")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "UIToolKitTests",
            dependencies: ["UIToolKit"],
            path: "Tests"
        )
    ]
)
