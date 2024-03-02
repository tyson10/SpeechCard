//
//  EditApp.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import SwiftUI

import Domain

@main
struct EditApp: App {
    var body: some Scene {
        WindowGroup {
            EditView(
                store: .init(
                    initialState: .init(
                        book: BookVO(
                            name: "",
                            targetLanguage: .korean,
                            originLanguage: .english,
                            contents: [
                                .init(origin: "origin", target: "target"),
                                .init(origin: "https://chojang2.tistory.com/entry/다이소-스탠드", target: "target")
                            ]
                        )
                    ),
                    reducer: {
                        EditMainFeature(
                            shelfUseCase: ShelfUseCaseStub(),
                            editUseCase: EditUseCaseStub()
                        )
                    }
                )
            )
        }
    }
}

class ShelfUseCaseStub: ShelfUseCase {
    func loadAllBooks() -> [Domain.BookVO] {
        return [
            BookVO(name: "Title1", targetLanguage: .english, originLanguage: .korean, contents: []),
            BookVO(name: "Title2", targetLanguage: .english, originLanguage: .korean, contents: [])
        ]
    }
    
    func addBook(book: Domain.BookVO) {
        
    }
    
    func deleteBook(name: String) {
        
    }
}

class EditUseCaseStub: EditUseCase {
    func add(book: Domain.BookVO) {
        
    }
    
    func update(to book: Domain.BookVO) {
        
    }
}
