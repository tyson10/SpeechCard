//
//  EditViewReducer.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import Foundation

import ComposableArchitecture

import Domain
import Utility

@Reducer
public struct EditMainFeature {
    
    @ObservableState
    public struct State: Equatable {
        var book: BookVO
        var selectedPairIndex: Int?
        let mode: Mode
        
        @Presents var inputViewState: EditWordPairFeature<DefaultWordPair>.State?
        
        public init(
            book: BookVO,
            mode: Mode
        ) {
            self.book = book
            self.mode = mode
        }
    }
    
    public enum Mode: Equatable {
        case add, edit
    }
    
    @CasePathable
    public enum Action {
        case inputBookName(String)
        case tapAddWords
        case tapWordPairItem(Int?)
        case append(DefaultWordPair)
        case delete(at: IndexSet)
        
        case tapComplete
        
        // TODO: Shelf 에서 저장하도록 전달.
        case save(new: BookVO)
        case update(BookVO)
        
        case inputViewAction(PresentationAction<EditWordPairFeature<DefaultWordPair>.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            Log.debug(action)
            switch action {
            case .inputBookName(let name):
                state.book.name = name
                
            case .tapAddWords:
                state.inputViewState = .init()
                
            case .tapWordPairItem(let index):
                let selected = state.book.contents[index!]
                state.inputViewState = .init(initialPair: selected, index: index)
                
            case .append(let pair):
                state.book.contents.append(pair)
            
            case .delete(let indexSet):
                state.book.contents.remove(atOffsets: indexSet)
                
            case .tapComplete:
                return state.mode == .add ?
                    .send(.save(new: state.book)) :
                    .send(.update(state.book))
            
            case .inputViewAction(let presentaionAction):
                handleInputViewAction(presentaionAction,state: &state)
                
            default:
                break
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
            guard let edited = state.inputViewState?.wordPair else { break }
            
            switch editAction {
            case .update:
                if let index = state.inputViewState?.index {
                    state.book.contents[index] = edited
                }
                state.inputViewState = nil
                
            case .add:
                state.book.contents.append(edited)
                state.inputViewState = nil
                
            default:
                break
            }
            
        case .dismiss:
            state.inputViewState = nil
        }
    }
}
