//
//  BookVO.swift
//  Domain
//
//  Created by Taeyoung Son on 11/11/23.
//

public struct BookVO: Equatable {
    var targetLangCode: String
    var originLangCode: String
    var contents: DefaultWordPairs
}
