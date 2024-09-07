//
//  DIContainer.swift
//  DIContainer
//
//  Created by Taeyoung Son on 1/17/24.
//

public protocol DIContainer {
    associatedtype View
    associatedtype Feature
    associatedtype UseCases
    associatedtype Repository
    
    func makeDefaultView() -> View
    func makeFeature() -> Feature
    func makeUseCases() -> UseCases
    func makeRepository() -> Repository
}
