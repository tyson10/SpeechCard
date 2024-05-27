//
//  CardView.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/07/08.
//

import SwiftUI

import Domain

public struct DefaultCardView: View {
    @State private var data: (any CardData)?
    
    public init(data: some CardData) {
        self.data = data
    }
    
    public var body: some View {
        if let data = data {
            ZStack {
                data.color
                
                Text(data.word)
            }
        }
    }
}
