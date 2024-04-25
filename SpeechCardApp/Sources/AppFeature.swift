//
//  AppFeature.swift
//  SpeechCardApp
//
//  Created by Taeyoung Son on 3/9/24.
//

import Domain

import ComposableArchitecture

@Reducer
struct AppFeature {
    
    @ObservableState
    struct State: Equatable {
        var editingBook: BookVO?
    }
    
    @CasePathable
    enum Action {
        case presentEdit(BookVO?)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            
            switch action {
            case .presentEdit(let book):
                state.editingBook = book
            }
            
            return .none
        }
    }
}
