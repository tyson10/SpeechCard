//
//  ShelfReducer.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import Combine

import Domain

import ComposableArchitecture
import SwiftSyntaxMacros

@Reducer
public struct ShelfReducer: Reducer {
    
    private let useCase: ShelfUseCase
    
    public init(useCase: ShelfUseCase) {
        self.useCase = useCase
    }
    
    public struct State: Equatable {
        public init(books: [BookVO] = [BookVO]()) {
            self.books = books
        }
        
        var books = [BookVO]()
        var selectedBook: BookVO?
    }
    
    public enum Action {
        case loadBooks
        case itemSelected(BookVO?)
        case editItemSelected
        case addBookSelected
        
        case setAllBooks([BookVO])
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadBooks:
                let allBooks = useCase.loadAllBooks()
                return .send(.setAllBooks(allBooks))
                
            case .itemSelected(let book):
                print("책 선택: \(book?.name)")
                state.selectedBook = book
                return .none
                
            case .editItemSelected:
                print("책 편집")
            case .addBookSelected:
                print("책 추가")
                
            case .setAllBooks(let books):
                state.books = books
            }
            
            return .none
        }
    }
}
