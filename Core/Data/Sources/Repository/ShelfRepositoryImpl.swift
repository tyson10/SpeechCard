//
//  ShelfRepositoryImpl.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Domain

public final class ShelfRepositoryImpl: ShelfRepository {
    
    
    private let dataSource: ShelfDataSource
    
    init(dataSource: ShelfDataSource) {
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
