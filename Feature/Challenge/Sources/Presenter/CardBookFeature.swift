//
//  CardBookFeature.swift
//  Challenge
//
//  Created by Taeyoung Son on 10/3/24.
//

import Foundation

import Combine

import ComposableArchitecture

import Domain
import CommonUI
import AppDependencies

import Utility

// TODO: 음성인식, 채점까지 다 되도록 구현. ChallengeFeature 기능에서 기능을 뺏어와야 함. ChallengeFeature의 Child로 구현.
@Reducer
public struct CardBookFeature<T: CardData>: Sendable {
    
    @Dependency(\.speechRecognitionUseCase) private var speechRecognitionUseCase: SpeechRecognitionUseCase
    
    @ObservableState
    public struct State: Equatable {
        private let book: BookVO
        
        var wordPairs: DefaultWordPairs
        var currentWordPair: DefaultWordPair?
        let targetLanguage: Language
        var content: CardContent<T>
        
        var transcript: String = ""
        
        var countDownState: CountDownFeature.State?
        
        var reportCard = ReportCard()
        
        init(book: BookVO) {
            self.book = book
            self.wordPairs = book.contents
            self.targetLanguage = book.targetLanguage
            self.content = .cover(
                T(
                    word: book.name,
                    color: .yellow
                )
            )
        }
    }
    
    @CasePathable
    public enum Action {
        case startCardBook
        case finishCardBook(ReportCard)
        
        case startNextCard
        case finishCard
        
        case startCountDown
        case endCountDown
        
        case startTranscribe
        case stopTranscribe
        
        case setContent(CardContent<T>)
        
        case grading
        case recordSession(ReportCard.Session)
        
        case receiveTranscript(String)
        case recognitionError(Error)
        
        case bindTranscript(AnyPublisher<Action, Never>)
        
        case countDownAction(CountDownFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startCardBook:
                return .send(.startNextCard)
            case .finishCardBook:
                break
                
            case .startNextCard:
                guard !state.wordPairs.isEmpty else {
                    return .send(.finishCardBook(state.reportCard))
                }
                
                let wordPair = state.wordPairs.removeFirst()
                state.currentWordPair = wordPair
                let content = CardContent.origin(
                    T(
                        word: wordPair.origin,
                        color: .clear
                    )
                )
                return .merge(
                    .send(.setContent(content)),
                    .send(.startCountDown),
                    .send(.startTranscribe)
                )
                
            case .finishCard:
                return .merge(
                    .send(.endCountDown),
                    .send(.stopTranscribe),
                    .send(.grading)
                )
                
            case .startTranscribe:
                // https://maramincho.tistory.com/133 참고
                let targetLanguage = state.targetLanguage
                return .run { @MainActor send in
                    let script = speechRecognitionUseCase.startTranscribing(targetLanguage)
                        .map({ script in
                            return .receiveTranscript(script)
                        })
                        .catch { error in
                            return Just(Action.recognitionError(error))
                        }
                        .eraseToAnyPublisher()

                    send(.bindTranscript(script))
                }
                
            case .bindTranscript(let publisher):
                return .publisher { publisher }
                
            case .stopTranscribe:
                return .run { @MainActor _ in
                    speechRecognitionUseCase.stopTranscribing()
                }
                
            case .receiveTranscript(let script):
                state.transcript = script
                
            case .startCountDown:
                state.countDownState = .init(seconds: 7)
                return .send(.countDownAction(.start))
                
            case .endCountDown:
                state.countDownState = nil
                
            case .countDownAction(let countDownAction):
                return handle(countDownAction)
                
            case .setContent(let newContent):
                state.content = newContent
                
            case .grading:
                guard let wordPair = state.currentWordPair else {
                    Log.error("채점할 대상 없음")
                    break
                }
                
                let session = ReportCard.Session(
                    question: wordPair.target,
                    correctAnswer: wordPair.origin,
                    userAnswer: state.transcript
                )
                
                let newContent = CardContent<T>.target(
                    T(
                        word: wordPair.target,
                        color: session.isCorrectAnswer ? .green : .red
                    )
                )
                
                return .merge(
                    .send(.recordSession(session)),
                    .send(.setContent(newContent))
                )
                
            case .recordSession(let session):
                state.reportCard.append(new: session)
                
            case .recognitionError(let error):
                Log.error("음성인식 실패 ->", error)
            }
            return .none
        }
        .ifLet(\.countDownState, action: \.countDownAction) {
            CountDownFeature()
        }
    }
    
    private func handle(_ action: CountDownFeature.Action) -> Effect<Action> {
        switch action {
        case .timeOver:
            return .send(.finishCard)
        default:
            return .none
        }
    }
}
