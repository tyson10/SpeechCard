//
//  Permission.swift
//  AppDependencies
//
//  Created by Taeyoung Son on 9/2/24.
//

import Domain
import Data

import Dependencies

struct SpeechRecognitionPermissionUseCaseKey: DependencyKey {
    public static var liveValue: any SpeechRecognitionPermissionUseCase {
        SpeechRecognitionPermissionUseCaseImpl()
    }
}

public extension DependencyValues {
    var speechRecognitionPermissionUseCase: any SpeechRecognitionPermissionUseCase {
        get { self[SpeechRecognitionPermissionUseCaseKey.self] }
        set { self[SpeechRecognitionPermissionUseCaseKey.self] = newValue }
    }
}
