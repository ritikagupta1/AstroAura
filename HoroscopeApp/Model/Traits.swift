//
//  Traits.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 09/10/24.
//

import Foundation
struct Traits: Codable {
    enum CodingKeys: String, CodingKey {
        case luckyNumber = "lucky_number"
        case luckyColor = "lucky_color"
        case compatibleSigns = "compatible_signs"
        case personalityTraits = "personality_trait"
        case element = "element"
        case rulingPlanet = "ruling_planet"
        case strengths = "strength"
        case weaknesses = "weakness"
        case startDate = "start_date"
        case endDate = "end_date"
    }
    let startDate: String
    let endDate: String
    let luckyNumber: Int
    let luckyColor: String
    let compatibleSigns: [String]
    let personalityTraits: String
    let element: String
    let rulingPlanet: String
    let strengths: [String]
    let weaknesses: [String]
}
