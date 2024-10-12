//
//  Horoscope.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 12/10/24.
//

import Foundation
struct Horoscope: Codable {
    struct HoroscopeReading: Codable {
        enum CodingKeys: String, CodingKey {
            case overall = "overall"
            case workCareer = "work_and_career"
            case loveRelationship = "love_and_relationships"
            case health = "health_and_wellbeing"
        }
        let overall: String
        let workCareer: String
        let loveRelationship: String
        let health: String
    }
    
    
    let startDate: String
    let endDate: String
    let horoscope: HoroscopeReading
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case horoscope = "horoscope"
    }
}
