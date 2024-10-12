//
//  CacheManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 12/10/24.
//

import Foundation
struct CachedObject<T: Codable> : Codable {
    let item: T
    var expirationDate: Date?
    
    var isExpired: Bool {
        guard let expirationDate = expirationDate else {
            // if expiration date is nil, it means data will never expire
            return false
        }
        
        return Date() > expirationDate
    }
}

class CacheManagerProvider {
    private static var managers: [String: Any] = [:]
    
    static func shared<T: Codable>(for type: T.Type, expirationInterval: TimeInterval? = nil) -> TraitsFileCacheManager<T> {
        let typeName = String(describing: type)
        if let existingManager = managers[typeName] as? TraitsFileCacheManager<T> {
            return existingManager
        }
        let newManager = TraitsFileCacheManager<T>(cacheType: type, expirationInterval: expirationInterval)
        managers[typeName] = newManager
        return newManager
    }
}

