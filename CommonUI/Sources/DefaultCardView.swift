//
//  CardView.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/07/08.
//

import SwiftUI

import Model

public struct DefaultCardView: CardViewType {
    @Binding public var state: CardViewState
    
    public var body: some View {
        ZStack {
            switch state.face {
            case .origin(let color):
                color
                Text(state.data.wordPair.origin)
            case .target(let color):
                color
                Text(state.data.wordPair.target)
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultCardView(
            state: .constant(DummyCardViewState())
        )
    }
}
