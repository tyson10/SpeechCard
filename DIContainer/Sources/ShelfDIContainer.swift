//
//  ShelfDIContainer.swift
//  ShelfDIContainer
//
//  Created by Taeyoung Son on 1/17/24.
//

import ComposableArchitecture

import Data
import Domain
import Shelf

public final class ShelfDIContainer: DIContainer {
    private let datasource: BookDataSource
    
    public init(datasource: BookDataSource) {
        self.datasource = datasource
    }
    
    public func makeDefaultView() -> ShelfView {
        return ShelfView(
            store: .init(
                initialState: .init(),
                reducer: makeFeature
            )
        )
    }
    
    public func makeFeature() -> ShelfFeature {
        return ShelfFeature(useCase: makeUseCase())
    }
    
    public func makeUseCase() -> ShelfUseCase {
        return ShelfUseCaseImpl(repository: makeRepository())
    }
    
    public func makeRepository() -> BookRepository {
        return BookRepositoryImpl(dataSource: datasource)
    }
}
