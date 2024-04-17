//
//  EditWordPairFeature.swift
//  Edit
//
//  Created by Taeyoung Son on 2/7/24.
//

import Foundation

import ComposableArchitecture

import Domain

@Reducer
public struct EditWordPairFeature<T: WordPairType> {
    
    @ObservableState
    public struct State: Equatable {
        var wordPair: T
        let index: Int?
        
        public init(
            initialPair: T = DefaultWordPair(origin: "", target: ""),
            index: Int? = nil
        ) {
            self.wordPair = initialPair
            self.index = index
        }
    }
    
    public enum Action {
        case cancel
        case tapComplete
        case update(index: Int)
        case add
        case inputOrigin(String)
        case inputTarget(String)
    }
    
    @Dependency(\.dismiss) var dismiss
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .inputOrigin(let input):
                state.wordPair.origin = input
                
            case .inputTarget(let input):
                state.wordPair.target = input
                
            case .tapComplete:
                if let index = state.index {
                    return .send(.update(index: index))
                } else {
                    return .send(.add)
                }
                
            default:
                break
            }
            return .none
        }
    }
}
