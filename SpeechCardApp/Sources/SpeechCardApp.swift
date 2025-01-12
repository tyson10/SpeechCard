import SwiftUI

import Domain
import Data

// TODO: DIContainer가 필요 없을까?
//import DIContainer

import Shelf
import Challenge

import Utility

import ComposableArchitecture

@main
struct SpeechCardApp: App {
    @State private var store: StoreOf<AppFeature>
    
    init() {
        store = StoreOf<AppFeature>(
            initialState: .init(),
            reducer: { AppFeature() }
        )
    }
    
    init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStackStore(store.scope(state: \.path, action: \.path)) {
                Button("Shelf로 이동") {
                    store.send(.shelfButtonTapped)
                }
            } destination: { store in
                switch store.state {
                case .shelf:
                    if let store = store.scope(state: \.shelf, action: \.shelf) {
                        ShelfView(store: store)
                    }
                    
                case .challenge:
                    if let store = store.scope(state: \.challenge, action: \.challenge) {
                        ChallengeView(store: store)
                    }
                }
            }
        }
    }
}
