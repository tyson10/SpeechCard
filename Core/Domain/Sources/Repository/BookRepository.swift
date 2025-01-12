//
//  ShelfRepository.swift
//  Domain
//
//  Created by Taeyoung Son on 1/5/24.
//

public protocol BookRepository: Sendable {
    func fetchAllBooks() async throws -> [BookVO]
    func create(book: BookVO) async throws
    func delete(book: BookVO) async throws
    func update(book: BookVO) async throws
}
