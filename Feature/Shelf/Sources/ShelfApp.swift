//
//  ShelfApp.swift
//  Shelf
//
//  Created by Taeyoung Son on 11/11/23.
//

import SwiftUI

import Domain
import Data

@main
struct ShelfApp: App {
    var body: some Scene {
        WindowGroup {
            ShelfView(
                store: .init(
                    initialState: .init(),
                    reducer: ShelfFeature.init,
                    withDependencies: {
                        $0.shelfUseCase = ShelfUseCaseImpl(repository: BookRepositoryImpl(dataSource: try! BookLocalDataSource()))
                    }
                )
            )
        }
    }
}
