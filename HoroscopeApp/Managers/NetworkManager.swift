//
//  NetworkManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 09/10/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let cache: URLCache
    
    private init(memoryCapacity: Int = 10_000_000, diskCapacity: Int = 50_000_000) {
        cache = CustomURLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "horoscope_cache")
    }
    
    let traitManager = CacheManagerProvider.shared(for: Traits.self)
    
    func getTraits(sign: Sign, completion: @escaping(Result<Traits,HoroscopeError>)-> Void) {
        // first check if the file cache already exists
        if let traits: Traits = traitManager.getFromFileCache(for: "\(sign.rawValue)") {
            completion(.success(traits))
            return
        }
        
        guard let url = EndPoint.traits(for: sign).url else {
            completion(.failure(.invalidSignName))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToCompleteRequest))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let traits = try decoder.decode(Traits.self, from: data)
                completion(.success(traits))
                // save in to cache
                self.traitManager.setInToFileCache(for: sign.rawValue, value: traits)
            }catch {
                completion(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
    
    
    func getHoroscopeReading(sign: Sign, timePeriod: HoroscopeTimePeriod, completion: @escaping(Result<Horoscope,HoroscopeError>)-> Void) {
        guard let url = EndPoint.horoscopeReading(sign: sign, timePeriod: timePeriod).url else {
            completion(.failure(.invalidSignName))
            return
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        
        // Create a URLSession with this configuration
        let urlSession: URLSession = URLSession(configuration: config)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        urlRequest.timeoutInterval = 30 // 30 seconds timeout for the request
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToCompleteRequest))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let reading = try decoder.decode(Horoscope.self, from: data)
                let cachedResponse = CachedURLResponse(
                    response: response,
                    data: data,
                    userInfo: ["expirationDate": Date().addingTimeInterval(timePeriod.expirationTimeInterval)],
                    storagePolicy: .allowed
                )
                self.cache.storeCachedResponse(cachedResponse, for: urlRequest)
                completion(.success(reading))
            }catch {
                completion(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
    
}

class CustomURLCache: URLCache {
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        guard let cachedResponse = super.cachedResponse(for: request),
              let expirationDate = cachedResponse.userInfo?["expirationDate"] as? Date else {
            return nil
        }
        
        // Check if the cached response has expired
        if Date() > expirationDate {
            // Remove the expired cache entry
            removeCachedResponse(for: request)
            return nil
        }
        
        return cachedResponse
    }
}
