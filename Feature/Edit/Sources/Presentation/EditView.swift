//
//  EditView.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import SwiftUI

import ComposableArchitecture
import Domain

public struct EditView: View {
    @State private var store: StoreOf<EditMainFeature>
    
    public init(store: StoreOf<EditMainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        TextField(
            "책 이름",
            text: $store.book.name.sending(\.inputBookName)
        )
        .font(.title)
        .padding(20)
        
        Button("Add words", systemImage: "plus.circle") {
            store.send(.tapAddWords)
        }
        .sheet(
            item: $store.scope(
                state: \.inputViewState,
                action: \.inputViewAction
            ),
            content: {
                PairInputView<DefaultWordPair>(store: $0)
            }
        )
        
        List(selection: $store.selectedPairIndex.sending(\.tapWordPairItem)) {
            ForEach(
                store.book.contents.indices,
                id: \.self,
                content: { listItem(for: store.book.contents[$0], at: $0) }
            )
            .onDelete(perform: { indexSet in
                store.send(.delete(at: indexSet))
            })
        }
    }
    
    private func listItem(for pair: DefaultWordPair, at index: Int) -> some View {
        return VStack(
            alignment: .leading,
            content: {
                Text(pair.origin)
                    .lineLimit(2)
                
                Text(pair.target)
                    .lineLimit(2)
            }
        )
        .tag(index)
    }
}

#Preview {
    EditView(store: .init(initialState: .init(book: BookVO(name: "", targetLanguage: .korean, originLanguage: .english, contents: [.init(origin: "origin", target: "target"), .init(origin: "https://chojang2.tistory.com/entry/다이소-스탠드", target: "target")])), reducer: { EditMainFeature(useCase: EditUseCaseStub()) }))
}
