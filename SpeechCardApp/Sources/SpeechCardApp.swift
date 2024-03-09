import SwiftUI

import Domain
import Data
import DIContainer

import Shelf
import Edit

import ComposableArchitecture

@main
struct SpeechCardApp: App {
    @State private var store: StoreOf<AppFeature>
    
    private var bookDataSource: BookDataSource?
    private var shelfDIContainer: ShelfDIContainer?
    private var editDIContainer: EditDIContainer?
    
    init() {
        store = .init(initialState: .init(), reducer: { AppFeature() })
        do {
            let dataSource = try BookLocalDataSource()
            bookDataSource = dataSource
            shelfDIContainer = ShelfDIContainer(datasource: dataSource)
            editDIContainer = EditDIContainer(datasource: dataSource)
        } catch {
            print("BookLocalDataSource 생성 실패", error)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if var shelfView = shelfView() {
                shelfView
                    .setAdd(action: {
                        store.send(.presentEdit(BookVO()))
                    })
                    .sheet(item: $store.editingBook.sending(\.presentEdit)) { book in
                        editView(with: book)
                    }
            }
        }
    }
    
    func shelfView() -> ShelfView? {
        return shelfDIContainer?.makeDefaultView()
    }
    
    func editView(with book: BookVO) -> EditView? {
        return editDIContainer?.makeView(
            with: book,
            mode: .add
        )
    }
}
