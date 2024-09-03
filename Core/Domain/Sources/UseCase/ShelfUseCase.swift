//
//  ShelfUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public protocol ShelfUseCase: Sendable {
    var loadAllBooks: @Sendable () async throws -> [BookVO] { get set }
    var addBook: @Sendable (BookVO) throws -> Void { get set }
    var update: @Sendable (BookVO) throws -> Void { get set }
    var deleteBook: @Sendable (BookVO) throws -> Void { get set }
}

public struct ShelfUseCaseImpl: ShelfUseCase {
    private let repository: BookRepository
    
    public var loadAllBooks: @Sendable () async throws -> [BookVO]
    public var addBook: @Sendable (BookVO) throws -> Void
    public var update: @Sendable (BookVO) throws -> Void
    public var deleteBook: @Sendable (BookVO) throws -> Void
    
    public init(repository: BookRepository) {
        self.repository = repository
        
        self.loadAllBooks = {
            return try repository.fetchAllBooks()
        }
        
        self.addBook = { book in
            try repository.create(book: book)
        }
        
        self.update = { book in
            try repository.update(book: book)
        }
        
        self.deleteBook = { book in
            try repository.delete(book: book)
        }
    }
}
