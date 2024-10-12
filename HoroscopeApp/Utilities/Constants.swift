//
//  Constants.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 02/10/24.
//

import Foundation
public enum Font {
    static let gothicMedium = "AppleSDGothicNeo-Medium"
    static let typeWriterBold = "AmericanTypewriter-Bold"
    static let typeWriter = "AmericanTypewriter"
    static let baskerVilleBoldItalic = "Baskerville-BoldItalic"
}

enum Constants {
    static let sunSignCellIdentifier = "sunSignCell"
    static let selectSignMessage = """
        Hi,
        Please select your sun sign
        """
    static let selectBirthDateMessage = """
           Not Sure??
        Select your date of birth
        """
    
    static let continueText = "Continue"
    
    static let zodiacSignMessageFormat = "Your zodiac sign is %@, Continue to know more about %@"
    
    static let  somethingWentWrong = "Something went wrong"
    static let ok = "Ok"
    
    static let strength = "Strengths: \n"
    static let weaknesses = "Weaknesses: \n"
    static let compatibleSigns = "Compatabile Signs:"
    static let personalityTraits = "Personality Traits:"
    static let rulingPlanet = "Ruling Planet :"
    static let element = "Element :"
    static let luckyNumber = "Lucky Number :"
    static let luckyColor = "Lucky Colour :"
    
    static let traits = "Traits"
    static let horoscope = "Horoscope"
    
    static let overall = "Overall"
    static let loveAndRelationships = "Love & Relationships"
    static let workAndCareer = "Work & Career"
    static let healthAndWellbeing = "Health & Wellbeing"
}
