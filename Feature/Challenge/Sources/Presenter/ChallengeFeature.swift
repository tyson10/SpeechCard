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
        let book: BookVO
        
        var card: CardBookFeature<T>.State?
        var reportCard: ReportCard?
        
        var introPopupShow: Bool = true
        
        public init(book: BookVO) {
            self.book = book
        }
    }
    
    @CasePathable
    public enum Action {
        case checkPermission
        case requestAuthorization
        
        case showIntro(Bool)
        case startChallenge
        
        case setReportCard(ReportCard)
        case showResultButtonTapped
        case showReportCard(ReportCard)
        
        case card(CardBookFeature<T>.Action)
    }
    
    public enum ID: String, Sendable {
        case cancelCountDown
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            Log.info(action)
            switch action {
            case .checkPermission:
                if speechRecognitionPermissionUseCase.isAuthorized {
                    return .send(.startChallenge)
                } else {
                    return .send(.requestAuthorization)
                }
                
            case .requestAuthorization:
                return .run { send in
                    try await speechRecognitionPermissionUseCase.request()
                    await send(.startChallenge)
                } catch: { error, send in
                    Log.error(error)
                }
                
            case .showIntro(let flag):
                state.introPopupShow = flag
                
            case .startChallenge:
                state.card = .init(book: state.book)
                
            case .setReportCard(let reportCard):
                state.reportCard = reportCard
                
            case .showResultButtonTapped:
                guard let reportCard = state.reportCard else {
                    Log.error("리포트카드 데이터 없음")
                    break
                }
                return .send(.showReportCard(reportCard))
                
            case .card(let cardAction):
                return reduceCardFeature(
                    &state,
                    cardAction
                )
                
            case .showReportCard:
                // 상위뷰에서 처리
                break
            }
            return .none
        }
        .ifLet(\.card, action: \.card) {
            CardBookFeature()
        }
    }
}

private extension ChallengeFeature {
    func reduceCardFeature(
        _ state: inout State,
        _ action: CardBookFeature<T>.Action
    ) -> Effect<Action> {
        var newEffect = Effect<ChallengeFeature.Action>.none
        
        switch action {
        case .finishCardBook(let reportCard):
            state.card = nil
            newEffect = .send(.setReportCard(reportCard))
        default:
            break
        }
        
        return newEffect
    }
}
