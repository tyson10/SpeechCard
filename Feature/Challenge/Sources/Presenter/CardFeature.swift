//
//  CardFeature.swift
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
public struct CardFeature<T: CardData>: Sendable {
    
    @Dependency(\.speechRecognitionUseCase) private var speechRecognitionUseCase: SpeechRecognitionUseCase
    
    @ObservableState
    public struct State: Equatable, Identifiable {
        public var id: UUID { wordPair.id }
        
        var wordPair: DefaultWordPair
        var content: CardContent<T>
        
        var cancellables = Set<AnyCancellable>()
        var transcript: String = ""
        
        var countDownState: CountDownFeature.State?
        
        init(wordPair: DefaultWordPair) {
            self.wordPair = wordPair
            self.content = .origin(
                T(
                    word: wordPair.origin,
                    color: .clear
                )
            )
        }
        
        public static func == (lhs: State, rhs: State) -> Bool {
            return lhs.wordPair == rhs.wordPair &&
            lhs.content == rhs.content &&
            lhs.transcript == rhs.transcript &&
            lhs.countDownState == rhs.countDownState
        }
    }
    
    @CasePathable
    public enum Action {
        case startCard
        case finishSpeech
        
        case startCountDown
        case endCountDown
        
        case startTranscribe
        case stopTranscribe
        
        case grading
        
        case receiveTranscript(String)
        case recognitionError(Error)
        
        case bindTranscript(AnyPublisher<Action, Never>)
        
        case countDownAction(CountDownFeature.Action)
        
        case toNextCard
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startCard:
                return .merge(
                    .send(.startCountDown),
                    .send(.startTranscribe)
                )
                
            case .finishSpeech:
                return .merge(
                    .send(.endCountDown),
                    .send(.stopTranscribe),
                    .send(.grading)
                )
                
            case .startTranscribe:
                // https://maramincho.tistory.com/133 참고
                return .run { @MainActor send in
                    let script = speechRecognitionUseCase.startTranscribe()
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
                    speechRecognitionUseCase.stopTranscribe()
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
                
            case .grading:
                let isCorrectAnswer = state.wordPair.target.lowercased() == state.transcript.lowercased()
                state.content = .target(
                    T(
                        word: state.wordPair.target,
                        color: isCorrectAnswer ? .green : .red
                    )
                )
                
            case .toNextCard:
                break
                
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
            return .send(.finishSpeech)
        default:
            return .none
        }
    }
}

/// 문제 풀 떄 카드에 보여져야 할 항목
/// 1. 단어(target)
/// 2. 잔여 시간
/// 3. 음성 인식으로 인식된 텍스트(실시간으로 업데이트)
///
/// 문제 푼 후 카드에 보여져야 할 항목
/// 1. 단어(origin)
/// 2. 음성인식 텍스트
/// 2. 맞았는지 틀렸는지
///
/// 결국 뭐가 필요하냐
/// 1. 단어(target/origin)
/// 2. 잔여시간
/// 3. 음성인식 텍스트
/// 4. 맞았는지 틀렸는지(ChallengeFeature로 결과 전달)
