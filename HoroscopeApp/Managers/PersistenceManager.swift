//
//  PersistenceManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import Foundation
enum PersistenceError: String, Error {
    case unableToSaveZodiacData = "There has been an error, Unable to save zodiac data"
    case unableToRetrieveZodiacData = "Unable to retrieve zodiac Data"
    case noZodiacDataFound = "There is no Zodiac data found"
}

enum PersistenceManager {
    static let defaults = UserDefaults.standard
    
    enum Key {
        static let zodiacData = "ZodiacSignData"
    }
    
    static func addZodiacData(zodiacs: [ZodiacSign.Zodiac]) -> PersistenceError? {
        do {
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(zodiacs)
            defaults.setValue(data, forKey: Key.zodiacData)
            return nil
            
        } catch {
            return .unableToSaveZodiacData
        }
    }
    
    static func retrieveZodiacData(completion: @escaping(Result<[ZodiacSign.Zodiac], PersistenceError>) -> Void) {
        guard let zodiacData =  defaults.data(forKey: Key.zodiacData) else {
            completion(.failure(.noZodiacDataFound))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let zodiacSigns = try decoder.decode([ZodiacSign.Zodiac].self, from: zodiacData)
            completion(.success(zodiacSigns))
        } catch {
            completion(.failure(.unableToRetrieveZodiacData))
        }
    }
}
