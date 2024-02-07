//
//  PairInputView.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import SwiftUI

import Domain

public struct PairInputView<T: WordPairType>: View {
    private var initialWordPair: T
    
    @State private var editing: T
    
    @Binding var updatedPair: T
    @Binding var presented: Bool
    
    public init(
        initialWordPair: T,
        presented: Binding<Bool>
    ) {
        self.initialWordPair = initialWordPair
        self._presented = presented
        self._updatedPair = .constant(initialWordPair)
        self._editing = .init(initialValue: initialWordPair)
    }
    
    public var body: some View {
        NavigationView(content: {
            VStack(spacing: 0) {
                ZStack(content: {
                    Color(.green)
                    
                    VStack(
                        spacing: 20,
                        content: {
                            Text("Origin")
                                .font(.title)
                            
                            TextEditor(text: $editing.origin)
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
                            TextEditor(text: $editing.target)
                        }
                    ).padding(10)
                })
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        updatedPair = editing
                        presented = false
                    }
                }
            })
        })
    }
}

#Preview {
    PairInputView(initialWordPair: DefaultWordPair(origin: "", target: ""), presented: .constant(false))
}
