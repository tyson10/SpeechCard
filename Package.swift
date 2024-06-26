// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpeechCard",
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMajor(from: "1.6.0")
        ),
        .package(
            url: "https://github.com/airbnb/lottie-spm.git",
            .upToNextMajor(from: "4.2.0")
        ),
        .package(
            url: "https://github.com/exyte/PopupView.git",
            .upToNextMajor(from: "2.9.1")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "SpeechCard")
    ]
)
