//
//  WordPair.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/15.
//

import Foundation

public struct WordPair: Equatable {
    private(set) var origin: String
    private(set) var target: String
    private(set) var createdAt: Date = Date()
    
    mutating func edit(origin: String? = nil, target: String? = nil) {
        if let origin = origin {
            self.origin = origin
        }
        
        if let target = target {
            self.target = target
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.origin == rhs.origin
    }
    
    public static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs.origin == rhs.origin
    }
}
