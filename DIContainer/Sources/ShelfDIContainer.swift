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

public actor ShelfDIContainer: DIContainer {
    private let datasource: BookDataSource
    
    public init(datasource: BookDataSource) {
        self.datasource = datasource
    }
    
    public func makeDefaultView() async -> ShelfView {
        let reducer = await makeFeature()
        
        return await ShelfView(
            store: .init(
                initialState: .init(),
                reducer: { reducer }
            )
        )
    }
    
    public func makeFeature() async -> ShelfFeature {
        return await withDependencies {
            $0.shelfUseCase = await makeUseCases().shelfUseCase
        } operation: {
            ShelfFeature()
        }
    }
    
    public func makeUseCases() async -> UseCases {
        return await UseCases(
            shelfUseCase: ShelfUseCaseImpl(repository: makeRepository())
        )
    }
    
    public func makeRepository() async -> BookRepository {
        return BookRepositoryImpl(dataSource: datasource)
    }
}

public extension ShelfDIContainer {
    struct UseCases: Sendable {
        let shelfUseCase: ShelfUseCase
    }
}
