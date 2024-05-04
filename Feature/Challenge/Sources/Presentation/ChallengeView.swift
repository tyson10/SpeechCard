//
//  ChallengeView.swift
//  Challenge
//
//  Created by Taeyoung Son on 4/29/24.
//

import SwiftUI

import CommonUI

import ComposableArchitecture

public struct ChallengeView: View {
    @State private var store: StoreOf<ChallengeFeature<DefaultCardContent>>
    
    public init(store: StoreOf<ChallengeFeature<DefaultCardContent>>) {
        self.store = store
    }
    
    public var body: some View {
        if let content = store.currentCardContent {
            DefaultCardView(content: content)
        }
    }
}
