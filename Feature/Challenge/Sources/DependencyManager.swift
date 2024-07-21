//
//  DependencyManager.swift
//  Challenge
//
//  Created by Taeyoung Son on 2024/07/21.
//

// TODO: 매니저 별도 모듈로 분리.
import Domain

import Dependencies

enum SpeechRecognitionKey: DependencyKey {
    public static var liveValue: any SpeechRecognitionUseCase {
        SpeechRecognitionUseCaseImpl(service: FakeSpeechRecognizeService())
    }
    
    public static var testValue: any SpeechRecognitionUseCase {
        SpeechRecognitionUseCaseImpl(service: FakeSpeechRecognizeService())
    }
}

extension DependencyValues {
    var speechRecognition: any SpeechRecognitionUseCase {
        get { self[SpeechRecognitionKey.self] }
        set { self[SpeechRecognitionKey.self] = newValue }
    }
}
