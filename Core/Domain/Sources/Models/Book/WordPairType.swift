//
//  WordPairType.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/15.
//

import Foundation

public protocol WordPairType: Hashable, Identifiable {
    var origin: String { get set }
    var target: String { get set }
}

public extension WordPairType {
    mutating func edit(origin: String? = nil, target: String? = nil) {
        if let origin = origin {
            self.origin = origin
        }
        
        if let target = target {
            self.target = target
        }
    }
}

public extension WordPairType {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.origin == rhs.origin
    }
    
    static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs.origin != rhs.origin
    }
}
