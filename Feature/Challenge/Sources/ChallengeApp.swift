//
//  ChallengeApp.swift
//  Challenge
//
//  Created by Taeyoung Son on 4/29/24.
//

import SwiftUI

import Domain

@main
struct ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ChallengeView(
                store: .init(
                    initialState: .init(book: BookVO(contents: [.init(origin: "origin", target: "target")])),
                    reducer: { ChallengeFeature() }
                )
            )
        }
    }
}
