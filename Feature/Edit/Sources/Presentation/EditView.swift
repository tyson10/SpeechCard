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
    private let store: StoreOf<EditViewReducer>
    
    public init(store: StoreOf<EditViewReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Text("책 이름")
                    .font(.largeTitle)
                TextField(
                    "책 이름",
                    text: viewStore.binding(
                        get: \.book.name,
                        send: EditViewReducer.Action.inputBookName
                    )
                )
            }
            
            Button("Add words", systemImage: "plus.circle") {
                
            }
        }
    }
}

#Preview {
    EditView(store: .init(initialState: .init(book: BookVO(name: "", targetLanguage: .korean, originLanguage: .english, contents: [])), reducer: { EditViewReducer() }))
}
