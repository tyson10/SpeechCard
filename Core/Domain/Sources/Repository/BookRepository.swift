//
//  ShelfRepository.swift
//  Domain
//
//  Created by Taeyoung Son on 1/5/24.
//

public protocol BookRepository {
    func fetchAllBooks() -> [BookVO]
    func createBook(book: BookVO)
    func deleteBook(name: String)
}
