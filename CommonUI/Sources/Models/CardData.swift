//
//  CardContent.swift
//  CommonUI
//
//  Created by Taeyoung Son on 5/4/24.
//

import SwiftUI

public protocol CardData: Equatable, Sendable {
    var word: String { get }
    var color: Color { get }
    
    init(word: String, color: Color)
}

public struct DefaultCardData: CardData {
    public let word: String
    public let color: Color
    
    public init(
        word: String,
        color: Color
    ) {
        self.word = word
        self.color = color
    }
}
