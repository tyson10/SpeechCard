//
//  CardBookView.swift
//  Challenge
//
//  Created by Taeyoung Son on 11/3/24.
//

import SwiftUI

import ComposableArchitecture

import CommonUI
import Extensions

public struct CardBookView<T: CardData>: View {
    
    @State private var store: StoreOf<CardBookFeature<T>>
    
    public init(store: StoreOf<CardBookFeature<T>>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            switch store.state.content {
            case .cover(let data):
                Text(data.word)
                    .font(.title)
                Button("시작하기") {
                    store.send(.startCardBook)
                }
                
            case .origin(let data):
                Spacer()
                
                Text("남은 시간(초): \(store.state.countDownState?.seconds ?? 0)")
                    .isHidden(store.state.countDownState == nil)
                
                Spacer()
                
                Text("\(data.word)")
                    .font(.system(size: 30))
                
                Spacer()
                
                Text(
                    store.state.transcript.isEmpty
                    ? "말하세요."
                    : store.state.transcript
                )
                .font(.system(size: 30))
                
            case .target(let data):
                Text("정답\n\(data.word)")
                    .foregroundStyle(data.color)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button("다음 카드로 넘어가기") {
                    store.send(.card(.startNext))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black
                .opacity(0.15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
}
