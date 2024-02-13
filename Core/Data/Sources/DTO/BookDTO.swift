//
//  BookDTO.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Domain

public struct BookDTO {
    var name: String
    var targetLangCode: String
    var originLangCode: String
    var contents: WordPairsDTO
}

extension BookDTO {
    var domain: BookVO {
        return BookVO(
            name: name,
            targetLanguage: Language(rawValue: targetLangCode)!,
            originLanguage: Language(rawValue: originLangCode)!,
            contents: contents.map(\.domain)
        )
    }
}
