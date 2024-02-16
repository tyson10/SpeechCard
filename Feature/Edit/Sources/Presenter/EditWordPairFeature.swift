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
        var initialPair: T
        var editingPair: T
        
        public init(
            initialPair: T = DefaultWordPair(origin: "", target: ""),
            editingPair: T = DefaultWordPair(origin: "", target: "")
        ) {
            self.initialPair = initialPair
            self.editingPair = editingPair
        }
    }
    
    public enum Action {
        case cancel
        case complete
        case inputOrigin(String)
        case inputTarget(String)
    }
    
    @Dependency(\.dismiss) var dismiss
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            print(action)
            return .none
        }
    }
}
