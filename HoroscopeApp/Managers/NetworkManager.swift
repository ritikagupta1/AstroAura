//
//  NetworkManager.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 09/10/24.
//

import Foundation

class NetworkManager {
    private init() {}
    
    static let shared = NetworkManager()
    
    let baseURL = "https://wd9j1sbsj0.execute-api.us-east-1.amazonaws.com/"
    let traitManager = CacheManagerProvider.shared(for: Traits.self)
    let horoscopeCacheManager = HoroscopeFileCacheManager.shared

    // Use the manager as before
    
    func getTraits(sign: Sign, completion: @escaping(Result<Traits,HoroscopeError>)-> Void) {
        
        // first check if the file already exists
        
        if let traits: Traits = traitManager.getFromFileCache(for: "\(sign.rawValue)") {
            completion(.success(traits))
            return
        }
        
        let urlString = baseURL + "traits?sign=\(sign.rawValue.lowercased())"
        guard let url = URL(string: urlString) else {
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
        
        //check if horoscopeReadingExists for time Period
        if let horoscopeReading: HoroscopeCacheReading = horoscopeCacheManager.getFromFileCache(for: sign.rawValue, timePeriod: timePeriod) {
            completion(.success(horoscopeReading.reading))
            return
        }
        
        let urlString = baseURL + "horoscope?sign=\(sign.rawValue.lowercased())&timePeriod=\(timePeriod.rawValue.lowercased())"
        guard let url = URL(string: urlString) else {
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
                let reading = try decoder.decode(Horoscope.self, from: data)
                completion(.success(reading))
                // save in to cache
                let horoscopeReading = HoroscopeCacheReading(reading: reading, timePeriod: timePeriod)
                self.horoscopeCacheManager.setInToFileCache(for: sign.rawValue, value: horoscopeReading, expirationInterval: timePeriod.expirationTimeInterval)
                
            }catch {
                completion(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
    
}
