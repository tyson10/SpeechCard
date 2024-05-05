//
//  ShelfReducer.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import Foundation
import Combine

import Domain
import Utility

import ComposableArchitecture

@Reducer
public struct ShelfFeature {
    
    private let useCase: ShelfUseCase
    
    public init(useCase: ShelfUseCase) {
        self.useCase = useCase
    }
    
    @ObservableState
    public struct State: Equatable {
        @Presents var editState: EditMainFeature.State?
        
        var books = [BookVO]()
        
        var selectedBook: BookVO?
        var editingBook: BookVO?
        
        var editPresented: Bool = false
        
        public init(books: [BookVO] = [BookVO]()) {
            self.books = books
        }
    }
    
    @CasePathable
    public enum Action {
        case editAction(PresentationAction<EditMainFeature.Action>)
        
        case loadBooks
        case itemSelected(BookVO?)
        case editItemSelected(BookVO?)
        case addBookBtnTapped
        case delete(BookVO)
        
        case setAllBooks([BookVO])
        
        case setEditPresented(Bool)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            Log.debug(action)
            switch action {
            case .loadBooks:
                do {
                    let allBooks = try useCase.loadAllBooks().sorted(by: <)
                    return .send(.setAllBooks(allBooks))
                } catch {
                    Log.error(error)
                }
                
            case .itemSelected(let book):
                state.selectedBook = book
                Log.debug("책 선택:", book?.name)
                
            case .editItemSelected(let book):
                state.editingBook = book
                if let book = book {
                    state.editState = .init(book: book, mode: .edit)
                }
                
            case .addBookBtnTapped:
                state.editState = .init(book: BookVO(), mode: .add)
                
            case .delete(let book):
                do {
                    try useCase.deleteBook(book: book)
                    return .send(.loadBooks)
                } catch {
                    Log.error(error)
                }
                
            case .setAllBooks(let books):
                state.books = books
                
            case .setEditPresented(let flag):
                state.editPresented = flag
                
            case .editAction(let presentaionAction):
                switch presentaionAction {
                case .presented(let editAction):
                    do {
                        switch editAction {
                        case .save(let newBook):
                            try useCase.addBook(book: newBook)
                            state.editState = nil
                            return .send(.loadBooks)
                            
                        case .update(let book):
                            try useCase.update(to: book)
                            state.editState = nil
                            return .send(.loadBooks)
                            
                        default:
                            break
                        }
                    } catch {
                        Log.error(error)
                    }
                    
                case .dismiss:
                    break
                }
            }
            return .none
        }
        .ifLet(\.$editState, action: \.editAction) {
            EditMainFeature()
        }
    }
}
