//
//  ShelfReducer.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import Combine

import Domain

import ComposableArchitecture

@Reducer
public struct ShelfReducer {
    
    private let useCase: ShelfUseCase
    
    public init(useCase: ShelfUseCase) {
        self.useCase = useCase
    }
    
    public struct State: Equatable {
        public init(books: [BookVO] = [BookVO]()) {
            self.books = books
        }
        
        var books = [BookVO]()
    }
    
    public enum Action {
        case loadBooks([BookVO])
        case itemSelected
        case editItemSelected
        case addBookSelected
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
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
}
