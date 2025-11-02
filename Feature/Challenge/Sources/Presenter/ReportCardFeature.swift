//
//  ReportCardFeature.swift
//  Challenge
//
//  Created by Taeyoung Son on 2/9/25.
//

import ComposableArchitecture

@Reducer
public struct ReportCardFeature {
    public init () { }
    
    @ObservableState
    public struct State: Equatable {
        var reportCard: ReportCard
        
        public init(reportCard: ReportCard) {
            self.reportCard = reportCard
        }
    }
    
    @CasePathable
    public enum Action {
        case endChallengeButtonTapped
    }
    
    public func reduce(
        into state: inout State,
        action: Action
    ) -> Effect<Action> {
        return .none
    }
}
