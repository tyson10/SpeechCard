//
//  ShelfUseCase.swift
//  AppDependencies
//
//  Created by Taeyoung Son on 9/5/24.
//

import Domain
import Data
import Utility

import Dependencies

enum ShelfUseCaseKey: DependencyKey {
    public static var liveValue: any ShelfUseCase {
        do {
            return try ShelfUseCaseImpl(repository: BookRepositoryImpl(dataSource: BookLocalDataSource()))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

public extension DependencyValues {
    var shelfUseCase: any ShelfUseCase {
        get { self[ShelfUseCaseKey.self] }
        set { self[ShelfUseCaseKey.self] = newValue }
    }
}
