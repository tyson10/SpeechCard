//
//  AppFeature.swift
//  SpeechCardApp
//
//  Created by Taeyoung Son on 3/9/24.
//

// MARK: Core
import Domain

// MARK: Feature
import Shelf
import Challenge

import Utility

import CommonUI

// MARK: Third Party
import ComposableArchitecture

@Reducer
struct AppFeature {
    typealias CardDataType = DefaultCardData
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
    }
    
    @CasePathable
    enum Action {
        case shelfButtonTapped
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .shelfButtonTapped:
                state.path.append(.shelf(.init()))
                
            case .path(let stackAction):
                switch stackAction {
                case .element(_, let pathAction):
                    return reducePath(&state, pathAction)
                default:
                    break
                }
            }
            return .none
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
}

extension AppFeature {
    @Reducer
    struct Path {
        @ObservableState
        enum State: Equatable {
            case shelf(ShelfFeature.State)
            case challenge(ChallengeFeature<CardDataType>.State)
        }
        
        @CasePathable
        enum Action {
            case shelf(ShelfFeature.Action)
            case challenge(ChallengeFeature<CardDataType>.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.shelf, action: \.shelf) {
                ShelfFeature()
            }
        }
    }
}

private extension AppFeature {
    func reducePath(
        _ state: inout State,
        _ action: Path.Action
    ) -> Effect<Action> {
        switch action {
        case .shelf(let shelfAction):
            return reduceShelfFeature(&state, shelfAction)
        case .challenge(let challengeAction):
            return reduceChallengeFeature(&state, challengeAction)
        }
    }
    
    func reduceShelfFeature(
        _ state: inout State,
        _ action: ShelfFeature.Action
    ) -> Effect<Action> {
        switch action {
        case .itemSelected(let book):
            if let book = book {
                state.path.append(.challenge(.init(book: book)))
            }
        default:
            break
        }
        
        return .none
    }
    
    func reduceChallengeFeature(
        _ state: inout State,
        _ action: ChallengeFeature<CardDataType>.Action
    ) -> Effect<Action> {
        switch action {
        default:
            break
        }
        
        return .none
    }
}
