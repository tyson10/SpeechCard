//
//  WordPairDTO.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Foundation

import Domain

struct WordPairDTO: WordPairType, Codable {
    public var origin: String
    public var target: String
    public var createdAt: Date
}

extension WordPairDTO {
    var domain: DefaultWordPair {
        return DefaultWordPair(
            origin: origin,
            target: target,
            createdAt: createdAt
        )
    }
}

typealias WordPairsDTO = [WordPairDTO]
