//
//  EndPoint.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 13/10/24.
//

import Foundation

struct EndPoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension EndPoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "wd9j1sbsj0.execute-api.us-east-1.amazonaws.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

extension EndPoint {
    static func traits(for sign: Sign) -> EndPoint {
        return EndPoint(
            path: "/traits",
            queryItems: [URLQueryItem(name: "sign", value: sign.rawValue.lowercased())])
    }
    
    static func horoscopeReading(sign: Sign, timePeriod: HoroscopeTimePeriod) -> EndPoint {
        return EndPoint(
            path: "/horoscope",
            queryItems: [URLQueryItem(name: "sign", value: sign.rawValue.lowercased()),
                         URLQueryItem(name: "timePeriod", value: timePeriod.rawValue.lowercased())])
    }
}
