//
//  PairInputView.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import SwiftUI

import Domain

public struct PairInputView<T: WordPairType>: View {
    @Binding var wordPair: T
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack(content: {
                Color(.green)
                
                VStack(
                    spacing: 20,
                    content: {
                        Text("Origin")
                            .font(.title)
                        
                        TextEditor(text: $wordPair.origin)
                            .background()
                    }
                ).padding(10)
            })
            
            ZStack(content: {
                Color(.orange)
                
                VStack(
                    spacing: 20,
                    content: {
                        Text("Target")
                            .font(.title)
                        TextEditor(text: $wordPair.target)
                    }
                ).padding(10)
            })
        }
        
    }
}

#Preview {
    PairInputView(wordPair: .constant(DefaultWordPair(origin: "", target: "")))
}
