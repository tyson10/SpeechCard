//
//  ChallengeFeature.swift
//  Challenge
//
//  Created by Taeyoung Son on 5/4/24.
//

import Combine

import Domain
import CommonUI
import Utility

import ComposableArchitecture

@Reducer
public struct ChallengeFeature<T: CardData> {
    private var bag = Set<AnyCancellable>()
    
    @Dependency(\.continuousClock) private var clock
    
    private let speechRecognitionUseCase: SpeechRecognitionUseCase
    
    public init(speechRecognitionUseCase: SpeechRecognitionUseCase) {
        self.speechRecognitionUseCase = speechRecognitionUseCase
        bindSpeechTranscript()
    }
    
    @ObservableState
    public struct State: Equatable {
        private let book: BookVO
        
        var bookContents: DefaultWordPairs
        var currentBookContent: DefaultWordPair?
        var currentCardContent: CardContent<T>?
        var remainedSeconds: Int?
        
        public init(
            book: BookVO,
            currentCardContent: CardContent<T>? = nil,
            remainedSeconds: Int? = nil
        ) {
            self.book = book
            self.bookContents = book.contents
            self.currentCardContent = currentCardContent
            self.remainedSeconds = remainedSeconds
        }
    }
    
    @CasePathable
    public enum Action : Sendable{
        case entered
        case introduce
        case startChallenge
        
        case setCardContent(CardContent<T>)
        
        case countDown(Int)
        case setRemainedSeconds(Int)
        
        case receiveTranscript(String)
        
        case timeOver
        
        case startRecord
        case finishRecord
        case showResult
    }
    
    public enum ID: String {
        case cancelCountDown
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            Log.info(action)
            switch action {
            case .entered:
                return .send(.introduce)
                
            case .introduce:
                return .send(.setCardContent(.introduce))
                
            case .startChallenge:
                guard !state.bookContents.isEmpty else { break }
                
                let content = state.bookContents.removeFirst()
                
                return .send(
                    .setCardContent(
                        .origin(
                            T(word: content.origin, color: .white, countDown: 7)
                        )
                    )
                )
                
            case .setCardContent(let content):
                state.currentCardContent = content
                
                switch content {
                case .origin(let data):
                    return .merge(
                        .send(.startRecord),
                        .send(.countDown(data.countDown))
                    )
                    
                case .target(let data):
                    return .send(.countDown(data.countDown))
                    
                case .introduce:
                    return .run { send in
                        try await Task.sleep(nanoseconds: 3_000_000_000)
                        await send(.startChallenge)
                    }
                }
                
            case .countDown(let totalSeconds):
                return runCountDown(from: totalSeconds)
                    .cancellable(id: ID.cancelCountDown)
                
            case .setRemainedSeconds(let seconds):
                state.remainedSeconds = seconds
                
            case .timeOver:
                return .send(.finishRecord)
                
            case .startRecord:
                break
                
            case .finishRecord:
                // TODO: + 마이크 off
                guard let target = state.currentBookContent?.target else { break }
                let data = T(
                    word: target,
                    color: .yellow,
                    countDown: 5
                )
                return .concatenate(
                    .cancel(id: ID.cancelCountDown),
                    .send(.setCardContent(.target(data)))
                )
                
            case .showResult:
                break
                
            case .receiveTranscript(let transcript):
                break
                
            }
            return .none
        }
    }
    
    private func runCountDown(from totalSeconds: Int) -> Effect<Action> {
        return .run { @MainActor [clock] send in
            send(.setRemainedSeconds(totalSeconds))
            
            var seconds = 0
            for await _ in clock.timer(interval: .seconds(1)) {
                seconds += 1
                
                let remainedSeconds = totalSeconds - seconds
                
                if remainedSeconds < 0 {
                    send(.timeOver)
                    break
                } else {
                    send(.setRemainedSeconds(remainedSeconds))
                }
            }
        }
    }
    
    private mutating func bindSpeechTranscript() {
        speechRecognitionUseCase.transcript
            .sink { completion in
                switch completion {
                case .finished:
                    Log.info("음성 인식 완료")
                case .failure(let error):
                    Log.error("음성 인식 에러", error)
                }
            } receiveValue: { transcript in
                _ = Effect.send(Action.receiveTranscript(transcript))
            }
            .store(in: &bag)
    }
}

///  1. 챌린지 입장
///  2. 안내 화면 표시(Start, Cancel 버튼이 있음)
///  3, 카운트 다운 3, 2, 1
///  4. 영어(Target language)가 나옴. 동시에 카운트 다운 되고 있음.
///  5. STT 활성화 됨.
///  6. Speech가 끝나면 한국어(Origin language)가 나오면서 채점됨.(5초 딜레이, 카운트도 표시)
///  7. 4~6 반복
///  8. 다 끝나면 리스트로 오답노트 보여줌.

/// 레코딩 시작시 해야할 것
///
///
/// 레코딩 종료시 해야할 것
/// 1. 레코더 종료
/// 2. 결과 표시
/// 3. 카운트 다운 종료 및 재시작
/// 4.
