//
//  BookVO.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public struct BookVO: Hashable, Identifiable {
    
    public var id: String { name }
    
    public var name: String
    public var targetLanguage: Language
    public var originLanguage: Language
    public var contents: DefaultWordPairs
    
    public init(
        name: String,
        targetLanguage: Language,
        originLanguage: Language,
        contents: DefaultWordPairs
    ) {
        self.name = name
        self.targetLanguage = targetLanguage
        self.originLanguage = originLanguage
        self.contents = contents
    }
}
