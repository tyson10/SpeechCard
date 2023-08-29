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
    var state: CardViewState { get set }
}

public protocol CardDataType {
    var wordPair: any WordPair { get set }
}

public protocol CardViewState {
    var face: CardFace { get set }
    
    mutating func flip(to face: CardFace) -> Void
}

public extension CardViewState {
    mutating func flip(to face: CardFace) {
        self.face = face
    }
}

public enum CardFace {
    case origin(Color), target(Color)
}
