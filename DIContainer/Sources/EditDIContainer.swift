//
//  EditDIContainer.swift
//  DIContainer
//
//  Created by Taeyoung Son on 1/31/24.
//

import Data
import Domain
import Edit

public final class EditDIContainer: DIContainer {
    private let datasource: BookDataSource
    private let book: BookVO
    
    public init(
        datasource: BookDataSource,
        book: BookVO
    ) {
        self.datasource = datasource
        self.book = book
    }
    
    public func makeView() -> EditView {
        return EditView(
            store: .init(
                initialState: .init(book: book),
                reducer: makeReducer
            )
        )
    }
    
    public func makeReducer() -> EditReducer {
        return EditReducer(useCase: makeUseCase())
    }
    
    public func makeUseCase() -> EditUseCase {
        return EditUseCaseImpl(repository: makeRepository())
    }
    
    public func makeRepository() -> BookRepository {
        return BookRepositoryImpl(dataSource: datasource)
    }
}
