//
//  ShelfReducer.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import Domain
import Utility
import AppDependencies

import ComposableArchitecture

@Reducer
public struct ShelfFeature: Sendable {
    @Dependency(\.shelfUseCase) private var useCase: ShelfUseCase
    
    public init() { }
    
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
        
        case setEditSrate(EditMainFeature.State?)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            Log.debug(action)
            switch action {
            case .loadBooks:
                return .run { send in
                    let allBooks = try await useCase.loadAllBooks().sorted(by: <)
                    await send(.setAllBooks(allBooks))
                } catch: { error, _ in
                    Log.error(error)
                }
                
            case .itemSelected(let book):
                state.selectedBook = book
                Log.debug("책 선택:", book?.name)
                
            case .editItemSelected(let book):
                state.editingBook = book
                if let book = book {
                    return .send(.setEditSrate(.init(book: book, mode: .edit)))
                }
                
            case .addBookBtnTapped:
                return .send(.setEditSrate(.init(book: BookVO(), mode: .add)))
                
            case .delete(let book):
                return .run { send in
                    try await useCase.deleteBook(book)
                    await send(.loadBooks)
                } catch: { error, _ in
                    Log.error(error)
                }
                
            case .setAllBooks(let books):
                state.books = books
                
            case .setEditSrate(let newState):
                state.editState = newState
                
            case .editAction(let presentaionAction):
                return makeEffect(for: presentaionAction)
            }
            return .none
        }
        .ifLet(\.$editState, action: \.editAction) {
            EditMainFeature()
        }
    }
}

// MARK: - Handle Edit Action
private extension ShelfFeature {
    func makeEffect(for action: PresentationAction<EditMainFeature.Action>) -> Effect<Action> {
        switch action {
        case .presented(let editAction):
            switch editAction {
            case .save(let newBook):
                return .run { send in
                    try await useCase.addBook(newBook)
                    await withTaskGroup(of: Void.self) { group in
                        group.addTask {
                            await send(.loadBooks)
                        }
                        group.addTask {
                            await send(.setEditSrate(nil))
                        }
                    }
                } catch: { error, send in
                    Log.error(error)
                }
                
            case .update(let book):
                return .run { send in
                    try await useCase.update(book)
                    await withTaskGroup(of: Void.self) { group in
                        group.addTask {
                            await send(.loadBooks)
                        }
                        group.addTask {
                            await send(.setEditSrate(nil))
                        }
                    }
                } catch: { error, send in
                    Log.error(error)
                }
                
            default:
                break
            }
            
        case .dismiss:
            break
        }
        
        return .none
    }
}
