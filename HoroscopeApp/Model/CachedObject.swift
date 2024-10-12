//
//  CachedObject.swift
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
