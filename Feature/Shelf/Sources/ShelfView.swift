//
//  ShelfView.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import SwiftUI

import ComposableArchitecture

struct ShelfView: View {
    let store: StoreOf<RepositoriesReducer>
    
    
    var body: some View {
        List {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(height: 200)
        }
        
    }
}

#Preview {
    ShelfView(store: .init(initialState: .init(), reducer: { }))
}
