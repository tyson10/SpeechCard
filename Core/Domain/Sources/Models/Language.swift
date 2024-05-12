//
//  Language.swift
//  Domain
//
//  Created by Taeyoung Son on 1/29/24.
//

// TODO: 추후 다른 언어도 지원
//

public enum Language: String {
    case korean
    case english
    
    public var localeId: String {
        switch self {
        case .korean:
            return "ko_KR"
        case .english:
            return "en"
        }
    }
}
