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
    
    func getTraits(sign: Sign, completion: @escaping(Result<Traits,HoroscopeError>)-> Void) {
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
            }catch {
                completion(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
}
