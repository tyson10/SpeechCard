//
//  ShelfRepository.swift
//  Domain
//
//  Created by Taeyoung Son on 1/5/24.
//

public protocol BookRepository {
    func fetchAllBooks() -> [BookVO]
    func create(book: BookVO)
    func deleteBook(name: String)
    func update(book: BookVO)
}
