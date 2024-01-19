//
//  ShelfView.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import SwiftUI

import ComposableArchitecture

import Domain

public struct ShelfView: View {
    private let store: StoreOf<ShelfReducer>
    
    public init(store: StoreOf<ShelfReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List(viewStore.books) { book in
                
                // TODO: 별도의 뷰로 구현
                Text(book.name)
                    .frame(height: 200)
                    .font(.title)
            }
        }
    }
}

#Preview {
    ShelfView(
        store: .init(
            initialState: .init(
                books: [
                    BookVO(name: "Title1", targetLangCode: "target", originLangCode: "origin", contents: []),
                    BookVO(name: "Title2", targetLangCode: "target", originLangCode: "origin", contents: [])
                ]
            ),
            reducer: {}
        )
    )
}
