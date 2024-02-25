//
//  EditUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 1/30/24.
//

public protocol EditUseCase {
    func update(to book: BookVO)
}

public class EditUseCaseImpl: EditUseCase {
    private let repository: BookRepository
    
    public init(repository: BookRepository) {
        self.repository = repository
    }
    
    public func update(to book: BookVO) {
        repository.update(book: book)
    }
}
