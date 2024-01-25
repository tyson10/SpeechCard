//
//  BookVO.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public struct BookVO: Hashable, Identifiable {
    
    public var id: String { name }
    
    public var name: String
    public var targetLangCode: String
    public var originLangCode: String
    public var contents: DefaultWordPairs
    
    public init(
        name: String,
        targetLangCode: String,
        originLangCode: String,
        contents: DefaultWordPairs
    ) {
        self.name = name
        self.targetLangCode = targetLangCode
        self.originLangCode = originLangCode
        self.contents = contents
    }
}
