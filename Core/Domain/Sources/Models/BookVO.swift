//
//  BookVO.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

import Foundation

public struct BookVO: Hashable, Identifiable {
    
    public var id: String { name }
    
    public var name: String
    public var targetLanguage: Language
    public var originLanguage: Language
    public var contents: DefaultWordPairs
    public var createdAt: Date
    
    public init(
        name: String = "",
        targetLanguage: Language = .english,
        originLanguage: Language = .korean,
        contents: DefaultWordPairs = [],
        createdAt: Date = Date()
    ) {
        self.name = name
        self.targetLanguage = targetLanguage
        self.originLanguage = originLanguage
        self.contents = contents
        self.createdAt = createdAt
    }
}

public extension BookVO {
    var isEmpty: Bool {
        return name.isEmpty && contents.isEmpty
    }
}
