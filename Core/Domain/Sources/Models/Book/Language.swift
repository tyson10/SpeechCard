//
//  Language.swift
//  Domain
//
//  Created by Taeyoung Son on 1/29/24.
//

// TODO: 추후 다른 언어도 지원
//

import Foundation

public enum Language: String, Sendable {
    case arabicSaudiArabia
    case chineseSimplified
    case chineseTraditionalHongKong
    case chineseTraditionalTaiwan
    case danishDenmark
    case dutchNetherlands
    case englishAustralia
    case englishCanada
    case englishIndia
    case englishUK
    case englishUS
    case finnishFinland
    case frenchCanada
    case frenchFrance
    case germanGermany
    case hebrewIsrael
    case hindiIndia
    case italianItaly
    case japaneseJapan
    case koreanSouthKorea
    case norwegianNorway
    case polishPoland
    case portugueseBrazil
    case russianRussia
    case spanishMexico
    case spanishSpain
    case swedishSweden
    case thaiThailand
    case turkishTurkey
}

public extension Language {
    var locale: Locale {
        let identifier: String
        switch self {
        case .arabicSaudiArabia: identifier = "ar-SA"
        case .chineseSimplified: identifier = "zh-CN"
        case .chineseTraditionalHongKong: identifier = "zh-HK"
        case .chineseTraditionalTaiwan: identifier = "zh-TW"
        case .danishDenmark: identifier = "da-DK"
        case .dutchNetherlands: identifier = "nl-NL"
        case .englishAustralia: identifier = "en-AU"
        case .englishCanada: identifier = "en-CA"
        case .englishIndia: identifier = "en-IN"
        case .englishUK: identifier = "en-GB"
        case .englishUS: identifier = "en-US"
        case .finnishFinland: identifier = "fi-FI"
        case .frenchCanada: identifier = "fr-CA"
        case .frenchFrance: identifier = "fr-FR"
        case .germanGermany: identifier = "de-DE"
        case .hebrewIsrael: identifier = "he-IL"
        case .hindiIndia: identifier = "hi-IN"
        case .italianItaly: identifier = "it-IT"
        case .japaneseJapan: identifier = "ja-JP"
        case .koreanSouthKorea: identifier = "ko-KR"
        case .norwegianNorway: identifier = "nb-NO"
        case .polishPoland: identifier = "pl-PL"
        case .portugueseBrazil: identifier = "pt-BR"
        case .russianRussia: identifier = "ru-RU"
        case .spanishMexico: identifier = "es-MX"
        case .spanishSpain: identifier = "es-ES"
        case .swedishSweden: identifier = "sv-SE"
        case .thaiThailand: identifier = "th-TH"
        case .turkishTurkey: identifier = "tr-TR"
        }
        return Locale(identifier: identifier)
    }
}
