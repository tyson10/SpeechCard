//
//  SpeechRecognitionUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 6/10/24.
//

import Combine

public protocol SpeechRecognitionUseCase {
    var transcript: AnyPublisher<String, Error> { get }
    func startTranscribe()
    func stopTranscribe()
}

public class SpeSpeechRecognitionUseCaseImpl: SpeechRecognitionUseCase {
    private let service: SpeechRecognizeService
    
    init(service: SpeechRecognizeService) {
        self.service = service
    }
    
    public var transcript: AnyPublisher<String, any Error> {
        return service.transcript
    }
    
    public func startTranscribe() {
        service.startTranscribe()
    }
    
    public func stopTranscribe() {
        service.stopTranscribe()
    }
}
