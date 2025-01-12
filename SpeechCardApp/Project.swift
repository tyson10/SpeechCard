import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "SpeechCardApp",
    products: [
        .app,
        .unitTests,
        .uiTests
    ],
    dependencies: [
        .Project.DIContainer.container
    ],
    additionalInfo: [
        "NSMicrophoneUsageDescription": "우리 앱에서 음성 인식을 위해 마이크에 접근해야 합니다.",
        "NSSpeechRecognitionUsageDescription": "우리 앱에서 음성 인식을 위해 음성 입력을 사용합니다."
    ]
)
