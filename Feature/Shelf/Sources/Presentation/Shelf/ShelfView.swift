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
                selection: $store.selectedBook.sending(\.itemSelected),
                content: listContent
            )
            .navigationTitle("Shelf")
            .onAppear(perform: {
                store.send(.loadBooks)
            })
            .toolbar(content: toolbarContent)
        }
        .sheet(
            item: $store.scope(
                state: \.editState,
                action: \.editAction
            ),
            content: {
                EditView(store: $0)
            }
        )
    }
    
    private func listContent() -> some View {
        return ForEach(store.books) { book in
           ShelfItemView(book: book)
               .frame(height: 150)
               .tag(book)
               .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                   Button(role: .destructive) {
                       store.send(.delete(book))
                   } label: {
                       Label("Delete", systemImage: "trash")
                   }
               }.swipeActions(edge: .leading, allowsFullSwipe: false) {
                   Button(role: .none) {
                       store.send(.editItemSelected(book))
                   } label: {
                       Label("Edit", systemImage: "pencil")
                   }
               }
       }
    }
    
    private func toolbarContent() -> some ToolbarContent {
        return ToolbarItem(placement: .topBarTrailing) {
            Button(
                "Add Book",
                systemImage: "plus.circle",
                action: { store.send(.addBookBtnTapped) }
            )
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
