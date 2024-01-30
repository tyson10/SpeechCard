//
//  EditViewReducer.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import ComposableArchitecture

//@Reducer
public struct ShelfReducer: Reducer {
    
    public struct State: Equatable {
        
    }
    
    public enum Action {
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
