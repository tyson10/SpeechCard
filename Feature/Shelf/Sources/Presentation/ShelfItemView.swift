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
        VStack(alignment: .leading, spacing: 20, content: {
            Text(book.name)
                .font(.largeTitle)
            
            VStack(alignment: .leading, content: {
                Text("언어")
                    .font(.headline)
                
                HStack(content: {
                    Text(book.originLanguage.rawValue)
                        .foregroundColor(.gray)
                        .font(.callout)
                    
                    Text("→")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    
                    Text(book.targetLanguage.rawValue)
                        .foregroundColor(.gray)
                        .font(.callout)
                })
                
            })
        })
        
    }
}

#Preview {
    ShelfItemView(book: BookVO(name: "Title1", targetLanguage: .english, originLanguage: .korean, contents: []))
}
