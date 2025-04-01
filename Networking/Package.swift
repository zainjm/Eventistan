// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        )
    ],
    dependencies: [
        .package(
            name: "Types",
            path: "Types"
        ),
        .package(
          url: "https://github.com/Alamofire/Alamofire.git",
          .upToNextMajor(from: "5.9.1")
        ),
        .package(
            url: "https://github.com/socketio/socket.io-client-swift",
            .upToNextMajor(from: "16.1.1")
        ),
        .package(
            url: "https://github.com/kean/Pulse.git",
            .upToNextMajor(from: "5.1.2")
        )
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                "Types",
                "Alamofire",
                .product(name: "SocketIO", package: "socket.io-client-swift"),
                .product(name: "Pulse", package: "Pulse"),
                .product(name: "PulseUI", package: "Pulse")
            ],
            path: "Sources"
        )
    ]
)
