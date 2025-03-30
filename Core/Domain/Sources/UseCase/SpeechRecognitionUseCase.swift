//
//  SpeechRecognitionUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 6/10/24.
//

import Combine

public protocol SpeechRecognitionUseCase: Sendable {
    @MainActor var startTranscribing: (Language) -> AnyPublisher<String, Error> { get set }
    @MainActor var stopTranscribing: () -> Void { get set }
}

public actor SpeechRecognitionUseCaseImpl: SpeechRecognitionUseCase, SpeechRecognizeServiceDelegate {
    private let service: SpeechRecognizeService
    
    @MainActor public var startTranscribing: (Language) -> AnyPublisher<String, Error> = { _ in return Empty().eraseToAnyPublisher() }
    @MainActor public var stopTranscribing: () -> Void = { }
    @MainActor public var transcribed: (Result<String, Error>) -> Void = { _ in }
    
    @MainActor private var transcript = PassthroughSubject<String, Error>()
    
    public init(service: SpeechRecognizeService) {
        self.service = service
        
        Task { @MainActor in
            self.startTranscribing = { @MainActor [weak self] language in
                guard let self = self else {
                    return Fail(error: InternalError.unexpectedNilSelf)
                        .eraseToAnyPublisher()
                }
                service.startTranscribing(with: language)
                return self.transcript.eraseToAnyPublisher()
            }
            
            self.transcribed = { [weak self] result in
                switch result {
                case .success(let transcript):
                    self?.transcript.send(transcript)
                case .failure(let error):
                    self?.transcript.send(completion: .failure(error))
                }
            }
            
            self.stopTranscribing = service.stopTranscribing
            self.service.delegate = self
        }
    }
}
