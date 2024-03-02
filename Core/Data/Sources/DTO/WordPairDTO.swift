//
//  WordPairDTO.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Foundation

import Domain

public struct WordPairDTO: Codable {
    public var origin: String
    public var target: String
}

public extension WordPairDTO {
    var domain: DefaultWordPair {
        return DefaultWordPair(
            origin: origin,
            target: target
        )
    }
}

public typealias WordPairsDTO = [WordPairDTO]
