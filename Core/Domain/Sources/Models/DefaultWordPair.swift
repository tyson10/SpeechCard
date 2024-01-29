//
//  DefaultWordPair.swift
//  Domain
//
//  Created by Taeyoung Son on 11/23/23.
//

import Foundation

public struct DefaultWordPair: WordPairType {
    
    public init(origin: Language, target: Language, createdAt: Date) {
        self.origin = origin
        self.target = target
        self.createdAt = createdAt
    }
    
    public var origin: Language
    public var target: Language
    public var createdAt: Date
}
