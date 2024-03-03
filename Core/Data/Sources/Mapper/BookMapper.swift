//
//  BookMapper.swift
//  Data
//
//  Created by Taeyoung Son on 3/3/24.
//

import Domain

extension BookVO {
    var data: BookDTO {
        return BookDTO(
            name: name,
            targetLangCode: targetLanguage.code,
            originLangCode: originLanguage.code,
            contents: contents.map(\.data)
        )
    }
}
