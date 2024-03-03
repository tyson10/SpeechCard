//
//  BookDTO.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Foundation

import Domain
import SwiftData

@Model
public class BookDTO {
    @Attribute(.unique) var name: String
    public var targetLangCode: String
    public var originLangCode: String
    public var contents: WordPairsDTO
    public var createdAt: Date
    
    public init(
        name: String,
        targetLangCode: String,
        originLangCode: String,
        contents: WordPairsDTO,
        createdAt: Date = Date()
    ) {
        self.name = name
        self.targetLangCode = targetLangCode
        self.originLangCode = originLangCode
        self.contents = contents
        self.createdAt = createdAt
    }
}

public extension BookDTO {
    var domain: BookVO {
        return BookVO(
            name: name,
            targetLanguage: Language(rawValue: targetLangCode)!,
            originLanguage: Language(rawValue: originLangCode)!,
            contents: contents.map(\.domain), 
            createdAt: createdAt
        )
    }
}
