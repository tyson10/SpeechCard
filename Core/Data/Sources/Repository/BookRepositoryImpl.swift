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
    
    public func fetchAllBooks() -> [BookVO] {
        return dataSource
            .fetchAllBooks()
            .map(\.domain)
    }
    
    public func createBook(book: Domain.BookVO) {
        
    }
    
    public func deleteBook(name: String) {
        
    }
}
