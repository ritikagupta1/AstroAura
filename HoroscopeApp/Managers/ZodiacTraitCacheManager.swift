//
//  ZodiacTraitCacheManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 10/10/24.
//

import Foundation

class CacheManagerProvider {
    private static var managers: [String: Any] = [:]
    
    static func shared<T: Codable>(for type: T.Type) -> FileCacheManager<T> {
        let typeName = String(describing: type)
        if let existingManager = managers[typeName] as? FileCacheManager<T> {
            return existingManager
        }
        let newManager = FileCacheManager<T>(cacheType: type)
        managers[typeName] = newManager
        return newManager
    }
}

class FileCacheManager<T: Codable>{
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let fileURL: URL
    
    private var cachedZodiacData: [String: T] = [:]
    

    fileprivate init(cacheType: T.Type) {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("HoroscopeCache")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        fileURL = cacheDirectory.appendingPathComponent("\(cacheType)Data.json")
        loadInitialCache()
    }
    
    
    private func loadInitialCache() {
        guard let data = try? Data(contentsOf: fileURL),
              let decodedData = try? JSONDecoder().decode([String: T].self, from: data) else {
            return
        }
        
        self.cachedZodiacData = decodedData
    }
    
    func getFromFileCache(for key: String) -> T? {
        return cachedZodiacData[key]
    }
    
    func setInToFileCache(for key: String, traits: T) {
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
