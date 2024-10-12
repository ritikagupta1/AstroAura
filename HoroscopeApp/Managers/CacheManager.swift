//
//  CacheManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 12/10/24.
//

import Foundation
class CacheManagerProvider {
    private static var managers: [String: Any] = [:]
    
    static func shared<T: Codable>(for type: T.Type, expirationInterval: TimeInterval? = nil) -> GenericFileCacheManager<T> {
        let typeName = String(describing: type)
        if let existingManager = managers[typeName] as? GenericFileCacheManager<T> {
            return existingManager
        }
        let newManager = GenericFileCacheManager<T>(cacheType: type, expirationInterval: expirationInterval)
        managers[typeName] = newManager
        return newManager
    }
}

