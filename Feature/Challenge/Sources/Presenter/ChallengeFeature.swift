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
import AppDependencies
import Extensions

import ComposableArchitecture

@Reducer
public struct ChallengeFeature<T: CardData>: Sendable {
    @Dependency(\.speechRecognitionPermissionUseCase) private var speechRecognitionPermissionUseCase: SpeechRecognitionPermissionUseCase
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        private let book: BookVO
        
        var bookContents: DefaultWordPairs
        
        var currentCardIndex = 0
        var card: CardFeature<T>.State?
        
        var reportCard = ReportCard()
        
        var introPopupShow: Bool = false
        
        public init(book: BookVO) {
            self.book = book
            self.bookContents = book.contents
        }
    }
    
    // TODO: Sendable 빼도 되는지?
    @CasePathable
    public enum Action {
        case entered
        
        case checkPermission
        case requestAuthorization
        
        case showIntro(Bool)
        case startChallenge
        case setCardFeatures
        
        case showResult
        
        case card(CardFeature<T>.Action)
    }
    
    public enum ID: String, Sendable {
        case cancelCountDown
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            Log.info(action)
            switch action {
            case .entered:
                return .send(.checkPermission)
                
            case .checkPermission:
                if speechRecognitionPermissionUseCase.isAuthorized {
                    return .send(.showIntro(true))
                } else {
                    return .send(.requestAuthorization)
                }
                
            case .requestAuthorization:
                return .run { send in
                    try await speechRecognitionPermissionUseCase.request()
                    await send(.showIntro(true))
                } catch: { error, send in
                    Log.error(error)
                }
                
            case .showIntro(let flag):
                state.introPopupShow = flag
                
            case .startChallenge:
                return .send(.setCardFeatures)
                
            case .setCardFeatures:
                guard let wordPair = state.bookContents[safe: state.currentCardIndex] else {
                    state.card = nil
                    return .send(.showResult)
                }
                
                state.card = .init(wordPair: wordPair)
                
            case .showResult:
                // TODO: ReportView 작업(state.reportCard 표시)
                break
                
            case .card(let cardAction):
                return reduceCardFeature(&state, cardAction)
            }
            return .none
        }
        .ifLet(\.card, action: \.card) {
            CardFeature()
        }
    }
}

private extension ChallengeFeature {
    func reduceCardFeature(
        _ state: inout State,
        _ action: CardFeature<T>.Action
    ) -> Effect<Action> {
        var newEffect = Effect<ChallengeFeature.Action>.none
        
        switch action {
        case .toNextCard:
            state.currentCardIndex += 1
            newEffect = .send(.setCardFeatures)
            
        case .recordSession(let session):
            state.reportCard.append(new: session)
            
        default:
            break
        }
        
        return newEffect
    }
}

///  0. 권한 확인 및 요청. 권한 설정이 제대로 되지 않으면 탈출
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
