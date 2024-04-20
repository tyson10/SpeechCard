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
    
    private func makeFakeReducer() -> ShelfFeature {
        return ShelfFeature(useCase: ShelfUseCaseStub())
    }
}


class ShelfUseCaseStub: ShelfUseCase {
    func update(to book: Domain.BookVO) throws {
        
    }
    
    func loadAllBooks() -> [Domain.BookVO] {
        return [
            BookVO(name: "Title1", targetLanguage: .english, originLanguage: .korean, contents: [], createdAt: Date()),
            BookVO(name: "Title2", targetLanguage: .english, originLanguage: .korean, contents: [], createdAt: Date())
        ]
    }
    
    func addBook(book: Domain.BookVO) {
        
    }
    
    func deleteBook(book: BookVO) {
        
    }
}
