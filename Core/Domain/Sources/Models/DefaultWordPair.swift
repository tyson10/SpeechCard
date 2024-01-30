//
//  DefaultWordPair.swift
//  Domain
//
//  Created by Taeyoung Son on 11/23/23.
//

import Foundation

public struct DefaultWordPair: WordPairType {
    
    public init(origin: String, target: String, createdAt: Date) {
        self.origin = origin
        self.target = target
        self.createdAt = createdAt
    }
    
    public var origin: String
    public var target: String
    public var createdAt: Date
}
