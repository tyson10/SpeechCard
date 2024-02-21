//
//  PairInputView.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import SwiftUI

import ComposableArchitecture
import Domain

public struct PairInputView<T: WordPairType>: View {
    private let store: StoreOf<EditWordPairFeature<T>>
    
    public init(store: StoreOf<EditWordPairFeature<T>>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView(content: {
                VStack(spacing: 0) {
                    ZStack(content: {
                        Color(.green)
                        
                        VStack(
                            spacing: 20,
                            content: {
                                Text("Origin")
                                    .font(.title)
                                
                                TextEditor(
                                    text: viewStore.binding(
                                        get: \.wordPair.origin,
                                        send: EditWordPairFeature.Action.inputOrigin
                                    )
                                )
                            }
                        ).padding(10)
                    })
                    
                    ZStack(content: {
                        Color(.orange)
                        
                        VStack(
                            spacing: 20,
                            content: {
                                Text("Target")
                                    .font(.title)
                                
                                TextEditor(
                                    text: viewStore.binding(
                                        get: \.wordPair.target,
                                        send: EditWordPairFeature.Action.inputTarget
                                    )
                                )
                            }
                        ).padding(10)
                    })
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("완료") {
                            viewStore.send(.save)
                        }
                    }
                })
            })
        }
    }
}

#Preview {
    PairInputView<DefaultWordPair>(
        store: .init(
            initialState: .init(),
            reducer: { EditWordPairFeature() }
        )
    )
}
