//
//  CardView.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/07/08.
//

import SwiftUI

import Domain

public struct DefaultCardView: View {
    @State private var content: any CardContent
    
    public init(content: some CardContent) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            content.color
            
            Text(content.word)
        }
    }
}
