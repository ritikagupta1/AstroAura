//
//  ZodiacTraitCacheManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 10/10/24.
//

import Foundation
class ZodiacTraitCacheManager {
    static let shared = ZodiacTraitCacheManager()
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let fileURL: URL
    
    private var cachedZodiacData: [String: Traits] = [:]
    
    private init() {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("ZodiacCache")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        fileURL = cacheDirectory.appendingPathComponent("ZodiacData.json")
        loadInitialCache()
    }
    
    
    private func loadInitialCache() {
        guard let data = try? Data(contentsOf: fileURL),
              let decodedData = try? JSONDecoder().decode([String: Traits].self, from: data) else {
            return
        }
        
        self.cachedZodiacData = decodedData
    }
    
    func getFromFileCache(for key: String) -> Traits? {
        return cachedZodiacData[key]
    }
    
    func setInToFileCache(for key: String, traits: Traits) {
        let encoder = JSONEncoder()
        self.cachedZodiacData[key] = traits
        do {
            let traitsJSONData = try encoder.encode(cachedZodiacData)
            try traitsJSONData.write(to: self.fileURL)
        } catch {
            print("Error saving cache: \(error.localizedDescription)")
        }
    }
    
    func clearCache() {
        cachedZodiacData.removeAll()
        try? fileManager.removeItem(at: fileURL)
    }
}
