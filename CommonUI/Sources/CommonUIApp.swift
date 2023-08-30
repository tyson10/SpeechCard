//
//  App.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/07/08.
//

import SwiftUI

@main
struct CommonUIApp: App {
    var body: some Scene {
        WindowGroup {
            DefaultCardView(
                state: .constant(DummyCardViewState())
            )
        }
    }
}
