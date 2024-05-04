//
//  ChallengeFeature.swift
//  Challenge
//
//  Created by Taeyoung Son on 5/4/24.
//

import Domain
import CommonUI

import ComposableArchitecture

@Reducer
public struct ChallengeFeature<T: CardContent> {
    
    @ObservableState
    public struct State: Equatable {
        private let book: BookVO
        
        var currentCardContent: T?
        var remainedSeconds: Int?
        
        public init(
            book: BookVO,
            currentCardContent: T? = nil,
            remainedSeconds: Int? = nil
        ) {
            self.book = book
            self.currentCardContent = currentCardContent
            self.remainedSeconds = remainedSeconds
        }
    }
    
    @CasePathable
    public enum Action {
        case set(card: T?)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .set(let content):
                state.currentCardContent = content
            }
            return .none
        }
    }
}
