//
//  WordPair.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/15.
//

import Foundation

public protocol WordPair: Equatable {
    var origin: String { get set }
    var target: String { get set }
    var createdAt: Date { get set }
}

public extension WordPair {
    mutating func edit(origin: String? = nil, target: String? = nil) {
        if let origin = origin {
            self.origin = origin
        }
        
        if let target = target {
            self.target = target
        }
    }
}

public extension WordPair {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.origin == rhs.origin
    }
    
    static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs.origin != rhs.origin
    }
}
