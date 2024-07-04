//
//  SpeechRecognitionUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 6/10/24.
//

import Combine

public protocol SpeechRecognitionUseCase {
    func startTranscribe() -> AnyPublisher<String, Error>
    func stopTranscribe()
}

public class SpeechRecognitionUseCaseImpl: SpeechRecognitionUseCase {
    private let service: SpeechRecognizeService
    
    public init(service: SpeechRecognizeService) {
        self.service = service
    }
    
    public func startTranscribe() -> AnyPublisher<String, Error> {
        return service.startTranscribe()
    }
    
    public func stopTranscribe() {
        service.stopTranscribe()
    }
}
