//
//  EditDIContainer.swift
//  DIContainer
//
//  Created by Taeyoung Son on 1/31/24.
//

import Foundation

import Data
import Domain
import Edit

public final class EditDIContainer: DIContainer {
    private let datasource: BookDataSource
    private var book: BookVO?
    
    public init(datasource: BookDataSource) {
        self.datasource = datasource
    }
    
    public func makeDefaultView() -> EditView {
        return EditView(
            store: .init(
                initialState: .init(book: book ?? BookVO(), mode: .edit),
                reducer: makeFeature
            )
        )
    }
    
    public func makeFeature() -> EditMainFeature {
        return EditMainFeature(
            shelfUseCase: makeShelfUseCase(),
            editUseCase: makeUseCase()
        )
    }
    
    public func makeUseCase() -> EditUseCase {
        return EditUseCaseImpl(repository: makeRepository())
    }
    
    public func makeShelfUseCase() -> ShelfUseCase {
        return ShelfUseCaseImpl(repository: makeRepository())
    }
    
    public func makeRepository() -> BookRepository {
        return BookRepositoryImpl(dataSource: datasource)
    }
}

extension EditDIContainer {
    public func makeView(
        with book: BookVO?,
        mode: EditMainFeature.Mode
    ) -> EditView {
        return EditView(
            store: .init(
                initialState: .init(book: book ?? BookVO(), mode: mode),
                reducer: makeFeature
            )
        )
    }
}
