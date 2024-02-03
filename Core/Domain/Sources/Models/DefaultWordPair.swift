//
//  DefaultWordPair.swift
//  Domain
//
//  Created by Taeyoung Son on 11/23/23.
//

import Foundation

public struct DefaultWordPair: WordPairType {
    
    public var id = UUID()
    public var origin: String
    public var target: String
    
    public init(
        origin: String,
        target: String
    ) {
        self.origin = origin
        self.target = target
    }
}
