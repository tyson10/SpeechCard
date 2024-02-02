//
//  EditViewReducer.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import Foundation

import ComposableArchitecture

import Domain

//@Reducer
public struct EditReducer: Reducer {
    
    private let useCase: EditUseCase
    
    public init(useCase: EditUseCase) {
        self.useCase = useCase
    }
    
    public struct State: Equatable {
        var book: BookVO
        
        public init(book: BookVO) {
            self.book = book
        }
    }
    
    public enum Action {
        case inputBookName(String)
        case tapAddWords
        case setBookContents(DefaultWordPairs)
        case delete(at: IndexSet)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .inputBookName(let name):
                state.book.name = name
                
            case .tapAddWords:
                break
                
            case .setBookContents(let contents):
                state.book.contents = contents
            
            case .delete(let indexSet):
                state.book.contents.remove(atOffsets: indexSet)
            }
            
            return .none
        }
    }
}
