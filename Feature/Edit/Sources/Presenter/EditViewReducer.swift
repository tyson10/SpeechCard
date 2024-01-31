//
//  EditViewReducer.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import ComposableArchitecture

import Domain

//@Reducer
public struct EditViewReducer: Reducer {
    
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
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .inputBookName(let name):
                state.book.name = name
            }
            
            return .none
        }
    }
}
