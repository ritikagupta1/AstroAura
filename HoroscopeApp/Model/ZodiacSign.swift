//
//  ZodiacSign.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import Foundation

struct ZodiacSign {
    struct Zodiac {
        let startDate: Date
        let endDate: Date
        let zodiacSign: String
    }
    
    let zodiacs: [Zodiac]
}
