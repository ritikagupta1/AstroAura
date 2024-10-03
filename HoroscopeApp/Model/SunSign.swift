//
//  SunSign.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 27/09/24.
//

import UIKit

enum Sign: String,CaseIterable, Codable {
    // The enum uses String as its raw value type, which allows easy mapping to JSON strings.
    case aries = "Aries"
    case taurus = "Taurus"
    case gemini = "Gemini"
    case cancer = "Cancer"
    case leo = "Leo"
    case virgo = "Virgo"
    case libra = "Libra"
    case scorpio = "Scorpio"
    case sagittarius = "Sagittarius"
    case capricorn = "Capricorn"
    case aquarius = "Aquarius"
    case pisces = "Pisces"
    
    var image: UIImage {
        switch self {
        case .aries: .aries
        case .taurus: .taurus
        case .gemini: .gemini
        case .cancer: .cancer
        case .leo: .leo
        case .virgo: .virgo
        case .libra: .libra
        case .scorpio: .scorpio
        case .sagittarius: .sagittarius
        case .capricorn: .capricorn
        case .aquarius: .aquarius
        case .pisces: .pisces
        }
    }
}
struct SunSign {
    let sign: Sign
    var name: String {
        sign.rawValue
    }
    var image: UIImage {
        sign.image
    }
}

var sunSigns: [SunSign] = Sign.allCases.map { SunSign(sign: $0) }
