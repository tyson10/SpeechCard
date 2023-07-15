//
//  WordPairs.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/15.
//

import Foundation

public typealias WordPairs = [WordPair]

public extension WordPairs {
    var origins: [String] {
        self.map(\.origin)
    }

    var targets: [String] {
        self.map(\.target)
    }

    mutating func append(origin: String, target: String) throws {
        guard !origins.contains(origin) else {
            throw InternalError.duplicated
        }

        self.append(WordPair(origin: origin, target: target))
    }

    mutating func delete(origin: String) {
        self.removeAll { pair in
            pair.origin == origin
        }
    }

    mutating func edit(at origin: String, to target: String) throws {
        guard let offset = self.firstIndex(where: { $0.origin == origin }) else {
            throw InternalError.notFound
        }
        
        self[offset] = WordPair(origin: origin, target: target)
    }
}
