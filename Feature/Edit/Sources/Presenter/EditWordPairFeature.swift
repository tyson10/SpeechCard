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
public struct EditWordPairFeature {
    public struct State: Equatable {
        var pair: DefaultWordPair
        
        public init(pair: DefaultWordPair = .init(origin: "", target: "")) {
            self.pair = pair
        }
    }
    
    public typealias Action = ActionCase
    
    public enum ActionCase {
        case cancel
        case complete
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
