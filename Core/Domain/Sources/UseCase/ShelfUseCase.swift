//
//  ShelfUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public protocol ShelfUseCase: Sendable {
    var loadAllBooks: @Sendable () async throws -> [BookVO] { get set }
    var addBook: @Sendable (BookVO) async throws -> Void { get set }
    var update: @Sendable (BookVO) async throws -> Void { get set }
    var deleteBook: @Sendable (BookVO) async throws -> Void { get set }
}

public struct ShelfUseCaseImpl: ShelfUseCase {
    private let repository: BookRepository
    
    public var loadAllBooks: @Sendable () async throws -> [BookVO]
    public var addBook: @Sendable (BookVO) async throws -> Void
    public var update: @Sendable (BookVO) async throws -> Void
    public var deleteBook: @Sendable (BookVO) async throws -> Void
    
    public init(repository: BookRepository) {
        self.repository = repository
        
        self.loadAllBooks = {
            try await repository.fetchAllBooks()
        }
        
        self.addBook = { book in
            try await repository.create(book: book)
        }
        
        self.update = { book in
            try await repository.update(book: book)
        }
        
        self.deleteBook = { book in
            try await repository.delete(book: book)
        }
    }
}
