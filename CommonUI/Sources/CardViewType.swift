//
//  CardViewType.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/23.
//

import SwiftUI

import Model

public protocol CardViewType: View {
    var data: CardDataType { get set }
}

public protocol CardDataType {
    var wordPair: any WordPair { get set }
    var isFlipped: Bool { get set }
}

public protocol FlashCardDataType: CardDataType {
    var bgColor: Color { get set }
    
    func flip() -> Void
}
