//
//  ZodiacSign.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import Foundation

struct ZodiacSign: Codable {
    struct Zodiac: Codable {
        let startDate: Date
        let endDate: Date
        let zodiacSign: Sign
    }
    
    let zodiacs: [Zodiac]
}
