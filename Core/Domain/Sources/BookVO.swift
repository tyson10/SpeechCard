//
//  BookVO.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public struct BookVO: Equatable {
    
    public init(name: String, targetLangCode: String, originLangCode: String, contents: DefaultWordPairs) {
        self.name = name
        self.targetLangCode = targetLangCode
        self.originLangCode = originLangCode
        self.contents = contents
    }
    
    var name: String
    var targetLangCode: String
    var originLangCode: String
    var contents: DefaultWordPairs
}
