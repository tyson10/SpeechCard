//
//  WordPairDTO.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Foundation

import Domain

struct WordPairDTO: Codable {
    public var origin: String
    public var target: String
}

extension WordPairDTO {
    var domain: DefaultWordPair {
        return DefaultWordPair(
            origin: origin,
            target: target
        )
    }
}

typealias WordPairsDTO = [WordPairDTO]
