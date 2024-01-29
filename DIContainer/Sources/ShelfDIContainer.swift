//
//  ShelfDIContainer.swift
//  ShelfDIContainer
//
//  Created by Taeyoung Son on 1/17/24.
//

import Data
import Domain
import Shelf

public final class ShelfDIContainer: DIContainer {
    private let datasource: ShelfDataSource
    
    init(datasource: ShelfDataSource) {
        self.datasource = datasource
    }
    
    public func makeView() -> ShelfView {
        return ShelfView(
            store: .init(
                initialState: .init(),
                reducer: makeReducer
            )
        )
    }
    
    public func makeReducer() -> ShelfReducer {
        return ShelfReducer(useCase: makeUseCase())
    }
    
    public func makeUseCase() -> ShelfUseCase {
        return ShelfUseCaseImpl(repository: makeRepository())
    }
    
    public func makeRepository() -> ShelfRepository {
        return ShelfRepositoryImpl(dataSource: datasource)
    }
}
