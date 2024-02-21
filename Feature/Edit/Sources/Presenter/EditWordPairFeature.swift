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
        
        public init(
            initialPair: T = DefaultWordPair(origin: "", target: "")
        ) {
            self.wordPair = initialPair
        }
    }
    
    public enum Action {
        case cancel
        case save
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
            default:
                break
            }
            return .none
        }
    }
}
