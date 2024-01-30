//
//  PairInputView.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import SwiftUI

import Domain

public struct PairInputView: View {
    @Binding var wordPair: any WordPairType
    
    public var body: some View {
        VStack(
            spacing: 20,
            content: {
                TextField("Origin", text: $wordPair.origin)
                TextField("Target", text: $wordPair.target)
            }
        )
    }
}

#Preview {
    PairInputView(wordPair: .constant(DefaultWordPair(origin: "", target: "", createdAt: .init())))
}
