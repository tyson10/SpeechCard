//
//  ShelfUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public protocol ShelfUseCase {
    func loadAllBooks() throws -> [BookVO]
    func addBook(book: BookVO) throws
    func deleteBook(book: BookVO) throws
}

public class ShelfUseCaseImpl: ShelfUseCase {
    
    private let repository: BookRepository
    
    public init(repository: BookRepository) {
        self.repository = repository
    }
    
    public func loadAllBooks() throws -> [BookVO] {
        return try repository.fetchAllBooks()
    }
    
    public func addBook(book: BookVO) throws {
        try repository.create(book: book)
    }
    
    public func deleteBook(book: BookVO) throws {
        try repository.delete(book: book)
    }
}
