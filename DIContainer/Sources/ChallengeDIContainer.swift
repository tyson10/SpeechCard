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

public final class ChallengeDIContainer<T: CardData>: DIContainer {
    private let book: BookVO
    
    public init(book: BookVO) {
        self.book = book
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
        return ChallengeFeature<T>(speechRecognitionUseCase: makeUseCase())
    }
    
    public func makeUseCase() -> SpeechRecognitionUseCase {
        return SpeSpeechRecognitionUseCaseImpl(service: makeRepository())
    }
    
    public func makeRepository() -> SpeechRecognizeService {
        return SpeechRecognizeServiceImpl()
    }
}
