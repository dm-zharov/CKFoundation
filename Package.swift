// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CKFoundation",
    defaultLocalization: "ru",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "CKFoundation",
            targets: ["CKFoundation"]
        )
    ],
    targets: [
        .target(
            name: "CKFoundation"
        )
    ]
)
