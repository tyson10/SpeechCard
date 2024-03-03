//
//  ShelfRepository.swift
//  Domain
//
//  Created by Taeyoung Son on 1/5/24.
//

public protocol BookRepository {
    func fetchAllBooks() throws -> [BookVO]
    func create(book: BookVO) throws
    func delete(book: BookVO) throws
    func update(book: BookVO) throws
}
