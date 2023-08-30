//
//  CardViewState.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/08/30.
//

import SwiftUI

import Model

public protocol CardViewState {
    var face: CardFace { get set }
    var data: CardDataType { get set }
    
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

public protocol CardDataType {
    var wordPair: any WordPair { get set }
}
