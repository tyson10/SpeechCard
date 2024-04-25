//
//  DIContainer.swift
//  DIContainer
//
//  Created by Taeyoung Son on 1/17/24.
//

public protocol DIContainer {
    associatedtype View
    associatedtype Feature
    associatedtype UseCase
    associatedtype Repository
    
    func makeDefaultView() -> View
    func makeFeature() -> Feature
    func makeUseCase() -> UseCase
    func makeRepository() -> Repository
}
