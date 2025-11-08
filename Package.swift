// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// 빌드 세팅 커스텀(https://docs.tuist.dev/ko/guides/develop/projects/dependencies#external-dependencies)
#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .framework, // default is .staticFramework
            "PopupView": .framework,
            "Lottie": .framework,
            "SwiftUIIntrospect": .framework
        ]
    )

#endif

let package = Package(
    name: "SpeechCard",
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMajor(from: "1.23.1")
        ),
        .package(
            url: "https://github.com/airbnb/lottie-spm.git",
            .upToNextMajor(from: "4.2.0")
        ),
        .package(
            url: "https://github.com/exyte/PopupView.git",
            .upToNextMajor(from: "4.1.15")
        ),
        // PopupView의 의존성이나 버전 선택이 잘못되어 강제로 지정
        .package(
            url: "https://github.com/siteline/swiftui-introspect",
            from: "26.0.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "SpeechCard")
    ]
)
