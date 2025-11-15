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
        case setContent(CardContent<T>)
        case recordSession(ReportCard.Session)
        
        case card(Card)
        case countDown(CountDown)
        case transcribe(Transcribe)
        
        public enum Card {
            case startNext
            case finish
            case grading
        }
        
        @CasePathable
        public enum CountDown {
            case start
            case end
            case countDownAction(CountDownFeature.Action)
        }
        
        public enum Transcribe {
            case start
            case stop
            case receiveTranscript(String)
            case recognitionError(Error)
            case bindTranscript(AnyPublisher<Action.Transcribe, Never>)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startCardBook:
                return .send(.card(.startNext))
                
            case .finishCardBook:
                break
                
            case .setContent(let newContent):
                state.content = newContent
                
            case .recordSession(let session):
                state.reportCard.append(new: session)
                
            case .card(let cardAction):
                return reduceCard(
                    &state,
                    cardAction
                )
                
            case .transcribe(let transcribeAction):
                return reduceTranscribe(
                    &state,
                    transcribeAction
                )
                
            case .countDown(let countDownAction):
                return reduceCountDown(
                    &state,
                    countDownAction
                )
                
            }
            return .none
        }
        .ifLet(\.countDownState, action: \.countDown.countDownAction) {
            CountDownFeature()
        }
    }
}

/// CardBook
/// Card
/// Timer
/// Transcribe


// MARK: - Reduce Card
private extension CardBookFeature {
    func reduceCard(
        _ state: inout State,
        _ action: CardBookFeature<T>.Action.Card
    ) -> Effect<Action> {
        switch action {
        case .startNext:
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
                .send(.countDown(.start)),
                .send(.transcribe(.start))
            )
            
        case .finish:
            return .merge(
                .send(.countDown(.end)),
                .send(.transcribe(.stop)),
                .send(.card(.grading))
            )
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
        }
        return .none
    }
}

// MARK: - Reduce Transcribe
private extension CardBookFeature {
    func reduceTranscribe(
        _ state: inout State,
        _ action: CardBookFeature<T>.Action.Transcribe
    ) -> Effect<Action> {
        switch action {
        case .start:
            // https://maramincho.tistory.com/133 참고
            let targetLanguage = state.targetLanguage
            return .run { @MainActor send in
                let script = speechRecognitionUseCase.startTranscribing(targetLanguage)
                    .map({ script in
                        return Action.Transcribe.receiveTranscript(script)
                    })
                    .catch { error in
                        return Just(.recognitionError(error))
                    }
                    .eraseToAnyPublisher()

                send(.transcribe(.bindTranscript(script)))
            }
            
        case .bindTranscript(let publisher):
            return .publisher { publisher.map(Action.transcribe) }
            
        case .stop:
            return .run { @MainActor _ in
                speechRecognitionUseCase.stopTranscribing()
            }
            
        case .receiveTranscript(let script):
            state.transcript = script
            
            
        case .recognitionError(let error):
            Log.error("음성인식 실패", error)
        }
        
        return .none
    }
}

// MARK: - Reduce CountDown
private extension CardBookFeature {
    func reduceCountDown(
        _ state: inout State,
        _ action: CardBookFeature<T>.Action.CountDown
    ) -> Effect<Action> {
        switch action {
        case .start:
            state.countDownState = .init(seconds: 7)
            return .send(.countDown(.countDownAction(.start)))
            
        case .end:
            state.countDownState = nil
            
        case .countDownAction(let countDownAction):
            return handle(countDownAction)
        }
        return .none
    }
    
    private func handle(_ action: CountDownFeature.Action) -> Effect<Action> {
        switch action {
        case .timeOver:
            return .send(.card(.finish))
        default:
            return .none
        }
    }
}
