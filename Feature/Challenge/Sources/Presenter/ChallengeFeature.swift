//
//  ChallengeFeature.swift
//  Challenge
//
//  Created by Taeyoung Son on 5/4/24.
//

import Domain
import CommonUI
import Utility

import ComposableArchitecture

@Reducer
public struct ChallengeFeature<T: CardData> {
    
    @ObservableState
    public struct State: Equatable {
        private let book: BookVO
        
        var currentCardContent: CardContent<T>?
        var remainedSeconds: Int?
        
        public init(
            book: BookVO,
            currentCardContent: CardContent<T>? = nil,
            remainedSeconds: Int? = nil
        ) {
            self.book = book
            self.currentCardContent = currentCardContent
            self.remainedSeconds = remainedSeconds
        }
    }
    
    @CasePathable
    public enum Action {
        case entered
        case introduce
        
        
        case setCardContent(CardContent<T>)
        case startRecord
        case finishRecord
        case showResult
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                Log.info("액션 정의")
            }
            return .none
        }
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
