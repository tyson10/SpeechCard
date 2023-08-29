//
//  DummyModel.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/08/29.
//

import Foundation

import Model

struct DummyCardData: CardDataType {
    var wordPair: any WordPair = DummyWordPair()
}

struct DummyCardViewState: CardViewState {
    var face: CardFace = .origin(.red)
}

struct DummyWordPair: WordPair {
    var origin: String = "origin_dummy"
    
    var target: String = "target_dummy"
    
    var createdAt: Date = .init()
}
