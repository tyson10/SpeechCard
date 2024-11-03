//
//  CardView.swift
//  Challenge
//
//  Created by Taeyoung Son on 11/3/24.
//

import SwiftUI

import ComposableArchitecture

import CommonUI

public struct CardView<T: CardData>: View {
    
    @State private var store: StoreOf<CardFeature<T>>
    
    public init(store: StoreOf<CardFeature<T>>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            VStack {
                if let countDownState = store.state.countDownState {
                    Text("남은 시간(초): \(countDownState.seconds)")
                }
                
                switch store.state.content {
                case .origin(let data):
                    Text("origin: \(data.word)")
                case .target(let data):
                    Text("target: \(data.word)")
                default:
                    Text("Hello")
                }
                
                Button("카운트 시작!") {
                    store.send(.startCountDown)
                }
            }
        }
    }
}

#Preview {
    CardView<DefaultCardData>(store: .init(initialState: .init(wordPair: .init(origin: "고맙습니다!", target: "Thank you!")), reducer: {
        CardFeature()
    }))
}
