//
//  ChallengeView.swift
//  Challenge
//
//  Created by Taeyoung Son on 4/29/24.
//

import SwiftUI

import CommonUI

import ComposableArchitecture

public struct ChallengeView<T: CardData>: View {
    @State private var store: StoreOf<ChallengeFeature<T>>
    
    public init(store: StoreOf<ChallengeFeature<T>>) {
        self.store = store
    }
    
    public var body: some View {
        if let content = store.currentCardContent {
            switch content {
            case .origin(let data), .target(let data):
                DefaultCardView(data: data)
            case .introduce:
                IntroduceView()
            }
            
        }
    }
}
