// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//#if TUIST
//    import ProjectDescription
//    import ProjectDescriptionHelpers
//
//
//    let packageSettings = PackageSettings(
//        productTypes: [
//            "Alamofire": .framework, // default is .staticFramework
//        ],
//        platforms: [.iOS]
//    )
//#endif


let package = Package(
    name: "FeaturePackage",
    platforms: [.iOS(.v15)],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMajor(from: "1.6.0")
        ),
        .package(
            url: "https://github.com/airbnb/lottie-spm.git",
            .upToNextMajor(from: "4.2.0")
        )
    ]
)
