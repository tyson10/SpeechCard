//
//  ShelfUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public protocol ShelfUseCase {
    func loadAllBooks() -> [BookVO]
    func addBook(book: BookVO)
    func deleteBook(name: String)
}

public class ShelfUseCaseImpl: ShelfUseCase {
    
    private let repository: BookRepository
    
    public init(repository: BookRepository) {
        self.repository = repository
    }
    
    public func loadAllBooks() -> [BookVO] {
        return repository.fetchAllBooks()
    }
    
    public func addBook(book: BookVO) {
        repository.create(book: book)
    }
    
    public func deleteBook(name: String) {
        repository.deleteBook(name: name)
    }
}
