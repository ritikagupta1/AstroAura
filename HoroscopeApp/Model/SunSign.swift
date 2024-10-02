//
//  SunSign.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 27/09/24.
//

import UIKit

struct SunSign {
    let name: String
    let image: UIImage
}

var sunSigns: [SunSign] = [
    SunSign(name: "Aries", image: .aries),
    SunSign(name: "Taurus", image: .taurus),
    SunSign(name: "Gemini", image: .gemini),
    SunSign(name: "Cancer", image: .cancer),
    SunSign(name: "Leo", image: .leo),
    SunSign(name: "Virgo", image: .virgo),
    SunSign(name: "Libra", image: .libra),
    SunSign(name: "Scorpio", image: .scorpio),
    SunSign(name: "Sagittarius", image: .sagittarius),
    SunSign(name: "Capricorn", image: .capricorn),
    SunSign(name: "Aquarius", image: .aquarius),
    SunSign(name: "Pisces", image: .pisces)
]
