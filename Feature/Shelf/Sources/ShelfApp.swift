//
//  ShelfApp.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import SwiftUI

@main
struct ShelfApp: App {
    var body: some Scene {
        WindowGroup {
            ShelfView(
                store: .init(
                    initialState: .init(),
                    reducer: makeFakeReducer
                )
            )
        }
    }
    
    private func makeFakeReducer() -> ShelfReducer {
        return ShelfReducer(useCase: ShelfIUseCaseStub())
    }
}
