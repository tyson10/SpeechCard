//
//  BookDTO.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Domain

import SwiftData

@Model
public struct BookDTO {
    @Attribute(.unique) var name: String
    public var targetLangCode: String
    public var originLangCode: String
    public var contents: WordPairsDTO
    
    public init(
        name: String,
        targetLangCode: String,
        originLangCode: String,
        contents: WordPairsDTO
    ) {
        self.name = name
        self.targetLangCode = targetLangCode
        self.originLangCode = originLangCode
        self.contents = contents
    }
}

public extension BookDTO {
    var domain: BookVO {
        return BookVO(
            name: name,
            targetLanguage: Language(rawValue: targetLangCode)!,
            originLanguage: Language(rawValue: originLangCode)!,
            contents: contents.map(\.domain)
        )
    }
}
