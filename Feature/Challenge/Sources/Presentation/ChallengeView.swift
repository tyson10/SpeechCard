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
        makeMainView()
            .centerPopup(
                isPresented: $store.introPopupShow.sending(\.showIntro),
                view: makeIntroContent
            )
            .onAppear {
                store.send(.entered)
            }
    }
    
    private func makeMainView() -> some View {
        if let cardStore = store.scope(state: \.card, action: \.card) {
            return AnyView(CardView(store: cardStore))
        } else {
            return AnyView(Text("끝!"))
        }
    }
    
    private func makeIntroContent() -> some View {
        return IntroPopupContent(confirmAction: {
            store.send(.showIntro(false))
            store.send(.startChallenge)
        })
    }
}
