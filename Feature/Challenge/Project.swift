//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Taeyoung Son on 11/11/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "Challenge",
    products: [
        .staticFramework,
        .unitTests,
        .uiTests
    ],
    dependencies: [
        .Project.CommonUI.ui,
        .ThirdParty.composableArchitecture
    ],
    // TODO: 로컬라이징
    additionalInfo: [
        "NSMicrophoneUsageDescription": "우리 앱에서 음성 인식을 위해 마이크에 접근해야 합니다.",
        "NSSpeechRecognitionUsageDescription": "우리 앱에서 음성 인식을 위해 음성 입력을 사용합니다."
    ],
    includeDemoApp: true
)
