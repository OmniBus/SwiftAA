// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftAA",
    products: [
        .library(
            name: "SwiftAA",
            targets: ["SwiftAA"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "aaplus-v1.91",
            dependencies: []),
        .target(
            name: "ObjCAA",
            dependencies: ["aaplus-v1.91"]),
        .target(
            name: "SwiftAA",
            dependencies: ["ObjCAA"]),
        .testTarget(
            name: "SwiftAATests",
            dependencies: ["SwiftAA"]),
        .testTarget(
            name: "ObjCAATests",
            dependencies: ["ObjCAA"]),
    ]
)
