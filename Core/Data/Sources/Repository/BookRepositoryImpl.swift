//
//  ShelfRepositoryImpl.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Domain

public actor BookRepositoryImpl: BookRepository {
    
    private let dataSource: BookDataSource
    
    public init(dataSource: BookDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchAllBooks() async throws -> [BookVO] {
        return try await dataSource
            .fetchAllBooks()
            .map(\.domain)
    }
    
    public func create(book: BookVO) async throws {
        try await dataSource.insert(book: book.data)
    }
    
    public func delete(book: BookVO) async throws {
        try await dataSource.deleteBook(name: book.name)
    }
    
    public func update(book: BookVO) async throws {
        try await dataSource.update(to: book.data)
    }
}
