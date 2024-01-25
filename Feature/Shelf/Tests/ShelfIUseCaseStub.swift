//
//  ShelfIUseCaseStub.swift
//  Shelf
//
//  Created by Taeyoung Son on 1/25/24.
//

import Domain

class ShelfIUseCaseStub: ShelfUseCase {
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
