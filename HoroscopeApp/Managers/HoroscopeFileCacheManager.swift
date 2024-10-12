//
//  HoroscopeFileCacheManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 12/10/24.
//

import Foundation

struct HoroscopeCacheReading: Codable {
    let reading: Horoscope
    let timePeriod: HoroscopeTimePeriod
}

class HoroscopeFileCacheManager {
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let fileURL: URL
    
    private var cachedData: [String: [CachedObject<HoroscopeCacheReading>]] = [:]
    
    static let shared = HoroscopeFileCacheManager()
    
    private init() {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("HoroscopeCache")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        fileURL = cacheDirectory.appendingPathComponent("HoroscopeData.json")
        loadInitialCache()
    }
    
    private func loadInitialCache() {
        guard let data = try? Data(contentsOf: fileURL),
              let decodedData = try? JSONDecoder().decode([String: [CachedObject<HoroscopeCacheReading>]].self, from: data) else {
            return
        }
        
        // Clean up expired items during load
        
        self.cachedData = decodedData.mapValues({ value in
            value.filter { !$0.isExpired }
        }).filter({ !$0.value.isEmpty })
    }
    
    
    func getFromFileCache(for key: String, timePeriod: HoroscopeTimePeriod) -> HoroscopeCacheReading? {
        guard var cachedItemArr = cachedData[key] else {
            return nil
        }
        cachedItemArr = cachedItemArr.filter { !$0.isExpired }
        cachedData[key] = cachedItemArr.isEmpty ? nil : cachedItemArr
        
       
        persistCache()
        
        return cachedItemArr.first { $0.item.timePeriod == timePeriod }?.item
    }
    
    
    func setInToFileCache(for key: String, value: HoroscopeCacheReading , expirationInterval: TimeInterval?) {
        var signReading = self.cachedData[key] ?? []
        let expirationDate = expirationInterval.map { Date().addingTimeInterval($0) }
        let cachedObject = CachedObject(item: value, expirationDate: expirationDate)
        
        // Remove existing entry for the same time period if exists
        signReading.removeAll { $0.item.timePeriod == value.timePeriod }
        
        signReading.append(cachedObject)
        cachedData[key] = signReading
        persistCache()
    }
    
    private func persistCache() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cachedData)
            try data.write(to: fileURL, options: .atomicWrite)
        } catch {
            print("Error persisting cache: \(error.localizedDescription)")
        }
    }
    
    func clearCache() {
        cachedData.removeAll()
        try? fileManager.removeItem(at: fileURL)
    }
}
