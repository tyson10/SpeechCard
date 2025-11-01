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
        // FIXME: 최상위 NavigationStack 1개만 사용하도록 수정
        NavigationStack(path: $store.scope(
            state: \.path,
            action: \.path)
        ) {
            makeMainView()
        } destination: { store in
            switch store.state {
            case .reportCard:
                if let store = store.scope(state: \.reportCard, action: \.reportCard) {
                    ReportCardView(store: store)
                }
            }
        }
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
            return AnyView(
                CardView(store: cardStore)
                    .padding(
                        EdgeInsets(
                            top: 100,
                            leading: 30,
                            bottom: 100,
                            trailing: 30
                        )
                    )
            )
        } else {
            return AnyView(
                Button("결과 확인!") {
                    store.send(.showResult)
                }
            )
        }
    }
    
    private func makeIntroContent() -> some View {
        return IntroPopupContent(confirmAction: {
            store.send(.showIntro(false))
            store.send(.startChallenge)
        })
    }
}
