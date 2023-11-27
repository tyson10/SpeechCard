//
//  ShelfUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public protocol ShelfUseCase {
    func loadAllBooks() -> [BookVO]
    func addBook(book: BookVO)
    func deleteBook(name: String)
}
