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
    private let store: StoreOf<EditReducer>
    
    public init(store: StoreOf<EditReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TextField(
                "책 이름",
                text: viewStore.binding(
                    get: \.book.name,
                    send: EditReducer.Action.inputBookName
                )
            )
            .font(.title)
            .padding(20)
            
            Button("Add words", systemImage: "plus.circle") {
                viewStore.send(.tapAddWords)
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.presentingInputView,
                    send: EditReducer.Action.setIsPresentedInput
                ),
                content: {
                    PairInputView(
                        initialWordPair: viewStore.newWordPair ?? DefaultWordPair(origin: "", target: ""),
                        presented: viewStore.binding(
                            get: \.presentingInputView,
                            send: EditReducer.Action.setIsPresentedInput
                        )
                    )
                }
            )
            
            List(
                selection: viewStore.binding(
                    get: \.selectedPairIndex,
                    send: EditReducer.Action.tapWordPairItem
                )
            ) {
                ForEach(
                    viewStore.book.contents.indices,
                    id: \.self,
                    content: { listItem(for: viewStore.book.contents[$0], at: $0) }
                )
                .onDelete(perform: { indexSet in
                    viewStore.send(.delete(at: indexSet))
                })
            }
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
    EditView(store: .init(initialState: .init(book: BookVO(name: "", targetLanguage: .korean, originLanguage: .english, contents: [.init(origin: "origin", target: "target"), .init(origin: "https://chojang2.tistory.com/entry/다이소-스탠드", target: "target")])), reducer: { EditReducer(useCase: EditUseCaseStub()) }))
}
