//
//  ShelfReducer.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import Foundation
import Combine

import Domain

import ComposableArchitecture

@Reducer
public struct ShelfFeature {
    
    private let useCase: ShelfUseCase
    
    public init(useCase: ShelfUseCase) {
        self.useCase = useCase
    }
    
    @ObservableState
    public struct State: Equatable {
        public init(books: [BookVO] = [BookVO]()) {
            self.books = books
        }
        
        var books = [BookVO]()
        var selectedBook: BookVO?
    }
    
    @CasePathable
    public enum Action {
        case loadBooks
        case itemSelected(BookVO?)
        case editItemSelected
        case addBookSelected
        case delete(BookVO)
        
        case setAllBooks([BookVO])
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadBooks:
                do {
                    let allBooks = try useCase.loadAllBooks()
                    return .send(.setAllBooks(allBooks))
                } catch {
                    fatalError(error.localizedDescription)
                }
                
            case .itemSelected(let book):
                print("책 선택: \(book?.name)")
                state.selectedBook = book
                return .none
                
            case .editItemSelected:
                print("책 편집")
            case .addBookSelected:
                print("책 추가")
                
            case .delete(let book):
                do {
                    try useCase.deleteBook(book: book)
                } catch {
                    fatalError(error.localizedDescription)
                }
                
            case .setAllBooks(let books):
                state.books = books
            }
            
            return .none
        }
    }
}
