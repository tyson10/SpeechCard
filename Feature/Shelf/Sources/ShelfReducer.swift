//
//  ShelfReducer.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import Combine

import Domain

import ComposableArchitecture

struct ShelfReducer: ReducerProtocol {
    
    private let useCase: ShelfUseCase
    
    struct State: Equatable { }
    
    enum Action {
        case itemSelected
        case editItemSelected
        case addBookSelected
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        return .none
    }
}
