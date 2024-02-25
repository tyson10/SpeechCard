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
    @State private var store: StoreOf<EditWordPairFeature<T>>
    
    public init(store: StoreOf<EditWordPairFeature<T>>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView(content: {
            mainView()
                .toolbar(content: toolBarContent)
        })
    }
    
    private func mainView() -> some View {
        return VStack(spacing: 0) {
            ZStack(content: {
                Color(.green)
                
                VStack(
                    spacing: 20,
                    content: {
                        Text("Origin")
                            .font(.title)
                        
                        TextEditor(text: $store.wordPair.origin.sending(\.inputOrigin))
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
                        
                        TextEditor(text: $store.wordPair.target.sending(\.inputTarget))
                    }
                ).padding(10)
            })
        }
    }
    
    private func toolBarContent() -> some ToolbarContent {
        return ToolbarItem(placement: .topBarTrailing) {
            Button("완료") {
                store.send(.tapComplete)
            }
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
