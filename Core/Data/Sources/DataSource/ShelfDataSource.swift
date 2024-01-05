//
//  ShelfDataSource.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

public protocol ShelfDataSource {
    func fetchAllBooks() -> [BookDTO]
    func saveBook(book: BookDTO)
    func deleteBook(name: String)
}
