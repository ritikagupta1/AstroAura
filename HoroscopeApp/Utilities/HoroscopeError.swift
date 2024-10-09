//
//  HoroscopeError.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 09/10/24.
//

import Foundation
enum HoroscopeError: String, Error {
    case invalidSignName = "This sign created an invalid request, Please try again later."
    case unableToCompleteRequest = "Unable to complete your request, Please Check your Internet Connection."
    case invalidResponse = "Invalid Response from server,Please try again."
    case invalidData = "The data received from the server was invalid.Please try again."
}
