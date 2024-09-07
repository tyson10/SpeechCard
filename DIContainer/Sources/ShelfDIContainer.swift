//
//  ShelfDIContainer.swift
//  ShelfDIContainer
//
//  Created by Taeyoung Son on 1/17/24.
//

import Data
import Domain
import Shelf

import ComposableArchitecture

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
        return withDependencies {
            $0.shelfUseCase = makeUseCases().shelfUseCase
        } operation: {
            ShelfFeature()
        }
    }
    
    public func makeUseCases() -> UseCases {
        return UseCases(
            shelfUseCase: ShelfUseCaseImpl(repository: makeRepository())
        )
    }
    
    public func makeRepository() -> BookRepository {
        return BookRepositoryImpl(dataSource: datasource)
    }
}

public extension ShelfDIContainer {
    struct UseCases {
        let shelfUseCase: ShelfUseCase
    }
}
