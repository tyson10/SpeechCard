//
//  DIContainer.swift
//  DIContainer
//
//  Created by Taeyoung Son on 1/17/24.
//

public protocol DIContainer: Sendable {
    associatedtype View
    associatedtype Feature
    associatedtype UseCases
    associatedtype Repository
    
    func makeDefaultView() async -> View
    func makeFeature() async -> Feature
    func makeUseCases() async -> UseCases
    func makeRepository() async -> Repository
}
