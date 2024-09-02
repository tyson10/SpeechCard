//
//  SpeechRecognitionUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 6/10/24.
//

import Combine

public protocol SpeechRecognitionUseCase: Sendable {
    var startTranscribe: @Sendable () -> AnyPublisher<String, Error> { get set }
    var stopTranscribe: @Sendable () -> Void { get set }
}

public struct SpeechRecognitionUseCaseImpl: SpeechRecognitionUseCase {
    private let service: SpeechRecognizeService
    public var startTranscribe: @Sendable () -> AnyPublisher<String, any Error>
    public var stopTranscribe: @Sendable () -> Void
    
    public init(service: SpeechRecognizeService) {
        self.service = service
        
        startTranscribe = {
            return service.startTranscribe()
        }
        
        stopTranscribe = {
            service.stopTranscribe()
        }
    }
}
