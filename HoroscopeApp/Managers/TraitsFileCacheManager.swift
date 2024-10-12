//
//  ZodiacTraitCacheManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 10/10/24.
//

import Foundation

class TraitsFileCacheManager<T: Codable>{
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let fileURL: URL
    
    private var cachedData: [String: CachedObject<T>] = [:]
    
    private let expirationInterval: TimeInterval?
    
    
    init(cacheType: T.Type, expirationInterval: TimeInterval? = nil) {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("HoroscopeCache")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        fileURL = cacheDirectory.appendingPathComponent("\(cacheType)Data.json")
        self.expirationInterval = expirationInterval
        loadInitialCache()
    }
    
    private func loadInitialCache() {
        guard let data = try? Data(contentsOf: fileURL),
              let decodedData = try? JSONDecoder().decode([String: CachedObject<T>].self, from: data) else {
            return
        }
        
        // Clean up expired items during load
        cachedData = decodedData.filter { !$0.value.isExpired }
    }
    
    func getFromFileCache(for key: String) -> T? {
        guard let cachedItem = cachedData[key] else {
            return nil
        }
        
        if cachedItem.isExpired {
            remove(for: key)
            return nil
        }
        
        return cachedItem.item
    }
    
    func setInToFileCache(for key: String, value: T) {
        let expirationDate = expirationInterval.map { Date().addingTimeInterval($0) }
        let cachedObject = CachedObject(item: value, expirationDate: expirationDate)
        cachedData[key] = cachedObject
        persistCache()
    }
    
    private func remove(for key: String) {
        cachedData.removeValue(forKey: key)
        persistCache()
    }
    
    private func persistCache() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cachedData)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Error persisting cache: \(error.localizedDescription)")
        }
    }
    
    func clearCache() {
        cachedData.removeAll()
        try? fileManager.removeItem(at: fileURL)
    }
}
