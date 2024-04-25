import SwiftUI

import Domain
import Data
import DIContainer

import Shelf

import Utility

import ComposableArchitecture

@main
struct SpeechCardApp: App {
    @State private var store: StoreOf<AppFeature> = .init(initialState: .init(), reducer: { AppFeature() })
    
    private var bookDataSource: BookDataSource?
    private var shelfDIContainer: ShelfDIContainer?
    
    init() {
        do {
            let dataSource = try BookLocalDataSource()
            bookDataSource = dataSource
            shelfDIContainer = ShelfDIContainer(datasource: dataSource)
        } catch {
            Log.error("BookLocalDataSource 생성 실패", error)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if var shelfView = shelfView() {
                shelfView     
            }
        }
    }
    
    func shelfView() -> ShelfView? {
        return shelfDIContainer?.makeDefaultView()
    }
}
