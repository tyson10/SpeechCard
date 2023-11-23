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
    
    struct State: Equatable {
        var books = [BookVO]()
    }
    
    enum Action {
        case loadBooks([BookVO])
        case itemSelected
        case editItemSelected
        case addBookSelected
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .loadBooks:
            let allBooks = useCase.loadAllBooks()
            return .send(.loadBooks(allBooks))
            
        case .itemSelected:
            return .none
            
        case .editItemSelected:
            return .none
            
        case .addBookSelected:
            return .none
        }
    }
}
