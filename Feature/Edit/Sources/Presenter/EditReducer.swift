//
//  EditViewReducer.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import Foundation

import ComposableArchitecture

import Domain

@Reducer
public struct EditReducer {
    
    private let useCase: EditUseCase
    
    public init(useCase: EditUseCase) {
        self.useCase = useCase
    }
    
    @ObservableState
    public struct State: Equatable {
        var book: BookVO
        var selectedPairIndex: Int?
        
        @Presents var inputViewState: EditWordPairFeature<DefaultWordPair>.State?
        
        public init(book: BookVO) {
            self.book = book
        }
    }
    
    @CasePathable
    public enum Action {
        case inputBookName(String)
        case tapAddWords
        case tapWordPairItem(Int?)
        case append(DefaultWordPair)
        case setIsPresentedInput(Bool)
        case setBookContents(DefaultWordPairs)
        case delete(at: IndexSet)
        
        case inputViewAction(PresentationAction<EditWordPairFeature<DefaultWordPair>.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            print(action)
            switch action {
            case .inputBookName(let name):
                state.book.name = name
                
            case .tapAddWords:
                state.inputViewState = .init()
                
            case .tapWordPairItem(let index):
                let selected = state.book.contents[index!]
                state.inputViewState = .init(initialPair: selected)
                
            case .append(let pair):
                state.book.contents.append(pair)
                
            case .setBookContents(let contents):
                state.book.contents = contents
            
            case .delete(let indexSet):
                state.book.contents.remove(atOffsets: indexSet)
            default:
                break
            }
            
            return .none
        }
        .ifLet(\.$inputViewState, action: \.inputViewAction) {
            EditWordPairFeature()
        }
    }
}
