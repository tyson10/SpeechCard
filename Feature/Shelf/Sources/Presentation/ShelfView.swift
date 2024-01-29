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
                        .frame(height: 150)
                        .tag(book)
                }
                .navigationTitle("Shelf")
                .onAppear(perform: {
                    viewStore.send(.loadBooks)
                })
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus.circle") {
                            // TODO: View에서 바로 EditView를 표시해도 되지만, 의존성이 커짐. 다른 방법이 있는지 확인 필요.
                        }
                    }
                })
            }
            
        }
    }
}

#Preview {
    ShelfView(
        store: .init(
            initialState: .init(),
            reducer: { ShelfReducer(useCase: ShelfUseCaseStub()) }
        )
    )
}
