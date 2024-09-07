//
//  ChallengeDIContainer.swift
//  DIContainer
//
//  Created by Taeyoung Son on 2024/06/26.
//

import Domain
import Data
import Challenge
import CommonUI

import ComposableArchitecture

public final class ChallengeDIContainer<T: CardData>: DIContainer {
    private let book: BookVO
    private let service: SpeechRecognizeService
    
    public init(
        book: BookVO,
        service: SpeechRecognizeService
    ) {
        self.book = book
        self.service = service
    }
    
    public func makeDefaultView() -> ChallengeView<T> {
        return ChallengeView(
            store: .init(
                initialState: .init(book: book),
                reducer: makeFeature
            )
        )
    }
    
    public func makeFeature() -> ChallengeFeature<T> {
        return withDependencies {
            $0.speechRecognitionUseCase = makeUseCases().speechRecognitionUseCase
        } operation: {
            ChallengeFeature<T>()
        }
    }
    
    public func makeUseCases() -> UseCases {
        return UseCases(
            speechRecognitionUseCase: SpeechRecognitionUseCaseImpl(service: makeRepository()),
            speechRecognitionPermissionUseCase: SpeechRecognitionPermissionUseCaseImpl()
        )
    }
    
    public func makeRepository() -> SpeechRecognizeService {
        return service
    }
}

public extension ChallengeDIContainer {
    struct UseCases {
        let speechRecognitionUseCase: SpeechRecognitionUseCase
        let speechRecognitionPermissionUseCase: SpeechRecognitionPermissionUseCase
    }
}
