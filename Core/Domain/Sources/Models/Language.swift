//
//  Language.swift
//  Domain
//
//  Created by Taeyoung Son on 1/29/24.
//

// TODO: 추후 다른 언어도 지원
//

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
    
    public var localeId: String {
        switch self {
        case .arabicSaudiArabia: return "ar-SA"
        case .chineseSimplified: return "zh-CN"
        case .chineseTraditionalHongKong: return "zh-HK"
        case .chineseTraditionalTaiwan: return "zh-TW"
        case .danishDenmark: return "da-DK"
        case .dutchNetherlands: return "nl-NL"
        case .englishAustralia: return "en-AU"
        case .englishCanada: return "en-CA"
        case .englishIndia: return "en-IN"
        case .englishUK: return "en-GB"
        case .englishUS: return "en-US"
        case .finnishFinland: return "fi-FI"
        case .frenchCanada: return "fr-CA"
        case .frenchFrance: return "fr-FR"
        case .germanGermany: return "de-DE"
        case .hebrewIsrael: return "he-IL"
        case .hindiIndia: return "hi-IN"
        case .italianItaly: return "it-IT"
        case .japaneseJapan: return "ja-JP"
        case .koreanSouthKorea: return "ko-KR"
        case .norwegianNorway: return "nb-NO"
        case .polishPoland: return "pl-PL"
        case .portugueseBrazil: return "pt-BR"
        case .russianRussia: return "ru-RU"
        case .spanishMexico: return "es-MX"
        case .spanishSpain: return "es-ES"
        case .swedishSweden: return "sv-SE"
        case .thaiThailand: return "th-TH"
        case .turkishTurkey: return "tr-TR"
        }
    }
}
