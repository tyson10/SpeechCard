//
//  CardView.swift
//  Challenge
//
//  Created by Taeyoung Son on 11/3/24.
//

import SwiftUI

import ComposableArchitecture

import CommonUI
import Extensions

public struct CardView<T: CardData>: View {
    
    @State private var store: StoreOf<CardFeature<T>>
    
    public init(store: StoreOf<CardFeature<T>>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Spacer()
            
            Text("남은 시간(초): \(store.state.countDownState?.seconds ?? 0)")
                .isHidden(store.state.countDownState == nil)
            
            Spacer()
            
            switch store.state.content {
            case .origin(let data):
                Text("\(data.word)")
                    .font(.system(size: 30))
                    .onAppear {
                        store.send(.startCard)
                    }
                
            case .target(let data):
                Text("정답\n\(data.word)")
                    .foregroundStyle(data.color)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Text(
                store.state.transcript.isEmpty ?
                "말하세요." : store.state.transcript
            )
            .font(.system(size: 30))
            
            Spacer()
            
            Button("다음 카드로 넘어가기") {
                store.send(.toNextCard)
            }
            .isHidden(store.state.countDownState != nil)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black
                .opacity(0.15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
}

#Preview {
    CardView<DefaultCardData>(store: .init(initialState: .init(wordPair: .init(origin: "고맙습니다!", target: "Thank you!"), targetLanguage: .englishUS), reducer: {
        CardFeature()
    }))
}
