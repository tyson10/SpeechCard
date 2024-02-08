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
    
    public struct State: Equatable {
        var book: BookVO
        var selectedPairIndex: Int?
        var newWordPair: DefaultWordPair?
        var presentingInputView = false
        
        var inputViewState = EditWordPairFeature.State()
        
        public init(book: BookVO) {
            self.book = book
        }
    }
    
    public typealias Action = ActionCase
    
    @CasePathable
    public enum ActionCase {
        case inputBookName(String)
        case tapAddWords
        case tapWordPairItem(Int?)
        case append(DefaultWordPair)
        case setIsPresentedInput(Bool)
        case setBookContents(DefaultWordPairs)
        case delete(at: IndexSet)
        
        case inputViewAction(EditWordPairFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.inputViewState, action: \.inputViewAction) {
            EditWordPairFeature()
        }
        Reduce { state, action in
            print(action)
            switch action {
            case .inputBookName(let name):
                state.book.name = name
                
            case .tapAddWords:
                state.newWordPair = DefaultWordPair(origin: "", target: "")
                return .send(.setIsPresentedInput(true))
                
            case .tapWordPairItem(let pair):
                state.selectedPairIndex = pair
                return .send(.setIsPresentedInput(true))
                
            case .append(let pair):
                state.book.contents.append(pair)
                
            case .setIsPresentedInput(let isPresented):
                state.presentingInputView = isPresented
                
            case .setBookContents(let contents):
                state.book.contents = contents
            
            case .delete(let indexSet):
                state.book.contents.remove(atOffsets: indexSet)
            default:
                break
            }
            
            return .none
        }
    }
}
