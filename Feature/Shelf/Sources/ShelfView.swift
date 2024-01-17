//
//  ShelfView.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import SwiftUI

import ComposableArchitecture

public struct ShelfView: View {
    private let store: StoreOf<ShelfReducer>
    
    public init(store: StoreOf<ShelfReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List(viewStore.books) { book in
                
                Text(book.name)
                    .frame(height: 200)
            }
        }
    }
}

#Preview {
    ShelfView(store: .init(initialState: .init(), reducer: {}))
}
