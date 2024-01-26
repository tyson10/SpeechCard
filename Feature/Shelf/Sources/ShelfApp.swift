//
//  ShelfApp.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import SwiftUI

import Domain

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
        return ShelfReducer(useCase: ShelfUseCaseStub())
    }
}


class ShelfUseCaseStub: ShelfUseCase {
    func loadAllBooks() -> [Domain.BookVO] {
        return [
            BookVO(name: "Title1", targetLangCode: "target", originLangCode: "origin", contents: []),
            BookVO(name: "Title2", targetLangCode: "target", originLangCode: "origin", contents: [])
        ]
    }
    
    func addBook(book: Domain.BookVO) {
        
    }
    
    func deleteBook(name: String) {
        
    }
}
