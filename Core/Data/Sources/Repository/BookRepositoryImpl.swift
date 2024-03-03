//
//  ShelfRepositoryImpl.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Domain

public final class BookRepositoryImpl: BookRepository {
    
    private let dataSource: BookDataSource
    
    public init(dataSource: BookDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchAllBooks() throws -> [BookVO] {
        return try dataSource
            .fetchAllBooks()
            .map(\.domain)
    }
    
    public func create(book: BookVO) throws {
        try dataSource.insert(book: book.data)
    }
    
    public func delete(book: BookVO) throws {
        try dataSource.deleteBook(name: book.name)
    }
    
    public func update(book: BookVO) throws {
        try dataSource.update(to: book.data)
    }
}
