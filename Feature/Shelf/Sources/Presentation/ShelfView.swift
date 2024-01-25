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
            NavigationView {
                List(
                    viewStore.books,
                    selection: viewStore.binding(
                        get: \.selectedBook,
                        send: ShelfReducer.Action.itemSelected
                    )
                ) { book in
                    
                    ShelfItemView(book: book)
                        .frame(height: 200)
                        .tag(book)
                }
                .navigationTitle("Shelf")
                .onAppear(perform: {
                    viewStore.send(.loadBooks)
                })
            }
        }
    }
}

#Preview {
    ShelfView(
        store: .init(
            initialState: .init(),
            reducer: { ShelfReducer(useCase: ShelfIUseCaseStub()) }
        )
    )
}
