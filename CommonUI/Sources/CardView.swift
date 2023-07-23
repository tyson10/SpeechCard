//
//  CardView.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/07/08.
//

import SwiftUI

import Model

public struct CardView: CardViewType {
    
    @Binding public var data: any CardDataType
    
    public var body: some View {
        ZStack {
            data.bgColor
                .opacity(0.3)
            
            if data.isFlipped {
                Text(data.wordPair.target)
            } else {
                Text(data.wordPair.origin)
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(data: .constant(DummyCardData()))
    }
}

struct DummyCardData: CardDataType {
    var bgColor: Color = .green
    var wordPair: any WordPair = DummyWordPair()
    var isFlipped: Bool = false
}

struct DummyWordPair: WordPair {
    var origin: String = "origin_dummy"
    
    var target: String = "target_dummy"
    
    var createdAt: Date = .init()
}
