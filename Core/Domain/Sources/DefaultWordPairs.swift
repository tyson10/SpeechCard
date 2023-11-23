//
//  WordPairs.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/15.
//

import Foundation

public typealias DefaultWordPairs = [DefaultWordPair]

public extension DefaultWordPairs {
    var origins: [String] {
        self.map(\.origin)
    }

    var targets: [String] {
        self.map(\.target)
    }

    mutating func append(pair: DefaultWordPair) throws {
        guard !origins.contains(pair.origin) else {
            throw InternalError.duplicated
        }

        self.append(pair)
    }

    mutating func delete(origin: String) {
        self.removeAll { pair in
            pair.origin == origin
        }
    }

    mutating func replace(at origin: String, to pair: DefaultWordPair) throws {
        guard let offset = self.firstIndex(where: { $0.origin == pair.origin }) else {
            throw InternalError.notFound
        }
        
        self[offset] = pair
    }
}
