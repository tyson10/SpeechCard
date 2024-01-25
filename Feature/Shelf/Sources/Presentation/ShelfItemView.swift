//
//  ShelfItemView.swift
//  Shelf
//
//  Created by Taeyoung Son on 1/25/24.
//

import SwiftUI

import Domain

struct ShelfItemView: View {
    @State private var book: BookVO
    
    init(book: BookVO) {
        self.book = book
    }
    
    var body: some View {
        Text(book.name)
            .font(.title)
    }
}

#Preview {
    ShelfItemView(book: BookVO(name: "Title1", targetLangCode: "target", originLangCode: "origin", contents: []))
}
