//
//  CounterFeature.swift
//  Challenge
//
//  Created by Taeyoung Son on 11/3/24.
//

import ComposableArchitecture

@Reducer
public struct CountDownFeature: Sendable {
    @Dependency(\.continuousClock) private var clock
    
    @ObservableState
    public struct State: Equatable {
        var seconds: Int
    }
    
    @CasePathable
    public enum Action {
        case start
        case setRemainedSeconds(Int)
        case timeOver
        case stopCounting
    }
    
    enum CancelID: String {
        case countDown
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .start:
            return runCountDown(from: state.seconds)
        
        case .setRemainedSeconds(let seconds):
            state.seconds = seconds
            
        case .timeOver:
            return .send(.stopCounting)
            
        case .stopCounting:
            return .cancel(id: CancelID.countDown)
        }
        
        return .none
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
        }.cancellable(id: CancelID.countDown)
    }
}
