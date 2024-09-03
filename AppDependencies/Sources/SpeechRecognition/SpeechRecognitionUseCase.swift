//
//  SpeechRecognition.swift
//  AppDependencies
//
//  Created by Taeyoung Son on 9/2/24.
//

import Domain
import Data

import Dependencies

enum SpeechRecognitionUseCaseKey: DependencyKey {
    public static var liveValue: any SpeechRecognitionUseCase {
        SpeechRecognitionUseCaseImpl(service: SpeechRecognizeServiceImpl())
    }
}

public extension DependencyValues {
    var speechRecognitionUseCase: any SpeechRecognitionUseCase {
        get { self[SpeechRecognitionUseCaseKey.self] }
        set { self[SpeechRecognitionUseCaseKey.self] = newValue }
    }
}
