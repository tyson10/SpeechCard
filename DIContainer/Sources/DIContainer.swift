//
//  DIContainer.swift
//  DIContainer
//
//  Created by Taeyoung Son on 1/17/24.
//

public protocol DIContainer {
    associatedtype View
    associatedtype Reducer
    associatedtype UseCase
    associatedtype Repository
    
    func makeView() -> View
    func makeReducer() -> Reducer
    func makeUseCase() -> UseCase
    func makeRepository() -> Repository
}
