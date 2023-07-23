//
//  CardView.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/07/08.
//

import SwiftUI

import Model

public struct CardView: View {
    
    @State private var bgColor: Color = .green
    @State private var wordPair: any WordPair
    @State private var isFlipped: Bool = false
    
    public init(wordPair: any WordPair) {
        self._wordPair = State(initialValue: wordPair)
    }
    
    public var body: some View {
        ZStack {
            bgColor
                .opacity(0.3)
            
            if isFlipped {
                Text(wordPair.origin)
            } else {
                Text(wordPair.target)
            }
            
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(wordPair: DummyWordPair())
    }
}

struct DummyWordPair: WordPair {
    var origin: String = "origin_dummy"
    
    var target: String = "target_dummy"
    
    var createdAt: Date = .init()
}
