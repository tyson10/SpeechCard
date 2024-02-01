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
                
            }
            
            List {
                ForEach(
                    viewStore.binding(
                        get: \.book.contents,
                        send: EditReducer.Action.setBookContents
                    )
                    ,
                    id: \.self
                ) { wordPair in
                    PairInputView(wordPair: wordPair)
                }
                .onDelete(perform: { indexSet in
                    viewStore.send(.delete(at: indexSet))
                })
            }
        }
    }
}

#Preview {
    EditView(store: .init(initialState: .init(book: BookVO(name: "", targetLanguage: .korean, originLanguage: .english, contents: [])), reducer: { EditReducer(useCase: EditUseCaseStub()) }))
}
