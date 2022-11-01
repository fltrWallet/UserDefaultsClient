// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "UserDefaultsClient",
    products: [
        .library(
            name: "UserDefaultsClientAPI",
            targets: [ "UserDefaultsClientAPI", ]),
        .library(
            name: "UserDefaultsClientLive",
            targets: [ "UserDefaultsClientLive", ]),
        .library(
            name: "UserDefaultsClientTest",
            targets: [ "UserDefaultsClientTest", ]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UserDefaultsClientAPI",
            dependencies: []),
        .target(
            name: "UserDefaultsClientLive",
            dependencies: [ "UserDefaultsClientAPI", ]),
        .target(
            name: "UserDefaultsClientTest",
            dependencies: [ "UserDefaultsClientAPI", ]),
        .testTarget(
            name: "UserDefaultsClientTests",
            dependencies: [ "UserDefaultsClientAPI",
                            "UserDefaultsClientLive",
                            "UserDefaultsClientTest", ]),
    ]
)
