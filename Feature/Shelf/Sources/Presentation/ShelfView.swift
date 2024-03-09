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
    @State private var store: StoreOf<ShelfFeature>
    private var addAction: (() -> Void)?
    
    public init(store: StoreOf<ShelfFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            List(
                store.books,
                selection: $store.selectedBook.sending(\.itemSelected)
            ) { book in
                
                ShelfItemView(book: book)
                    .frame(height: 150)
                    .tag(book)
            }
            .navigationTitle("Shelf")
            .onAppear(perform: {
                store.send(.loadBooks)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        "Add Book",
                        systemImage: "plus.circle",
                        action: { addAction?() }
                    )
                }
            })
        }
    }
    
    public mutating func setAdd(action: @escaping () -> Void) -> Self {
        self.addAction = action
        return self
    }
}

#Preview {
    ShelfView(
        store: .init(
            initialState: .init(),
            reducer: { ShelfFeature(useCase: ShelfUseCaseStub()) }
        )
    )
}
