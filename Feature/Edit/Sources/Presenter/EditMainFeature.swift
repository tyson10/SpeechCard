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
public struct EditMainFeature {
    
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
        case delete(at: IndexSet)
        case save
        
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
                state.selectedPairIndex = index
                
            case .append(let pair):
                state.book.contents.append(pair)
            
            case .delete(let indexSet):
                state.book.contents.remove(atOffsets: indexSet)
                
            case .save:
                // TODO: 업데이트 or 추가 분기 구현 필요
                useCase.add(book: state.book)
            
            case .inputViewAction(let presentaionAction):
                handleInputViewAction(presentaionAction,state: &state)
            }
            
            return .none
        }
        .ifLet(\.$inputViewState, action: \.inputViewAction) {
            EditWordPairFeature()
        }
    }
    
    private func handleInputViewAction(
        _ action: PresentationAction<EditWordPairFeature<DefaultWordPair>.Action>,
        state: inout State
    ) {
        switch action {
        case .presented(let editAction):
            switch editAction {
            case .save:
                if let index = state.selectedPairIndex, 
                    let edited = state.inputViewState?.wordPair {
                    state.book.contents[index] = edited
                }
                state.inputViewState = nil
                state.selectedPairIndex = nil
            default:
                break
            }
            
        case .dismiss:
            state.selectedPairIndex = nil
        }
    }
}
